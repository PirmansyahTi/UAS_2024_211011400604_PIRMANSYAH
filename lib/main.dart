// main.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service/crypto_cubit.dart';
import 'service/crypto_repository.dart';
import 'service/crypto_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CryptoRepository>(
          create: (_) => CryptoRepository(),
        ),
        BlocProvider<CryptoCubit>(
          create: (context) => CryptoCubit(context.read<CryptoRepository>())..fetchCryptos(),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto Prices',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}

class CryptoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
      ),
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return Center(child: Text('Error loading cryptos'));
          } else {
            return ListView.builder(
              itemCount: state.cryptos.length,
              itemBuilder: (context, index) {
                final crypto = state.cryptos[index];
                return ListTile(
                  title: Text(crypto.name),
                  subtitle: Text(crypto.symbol),
                  trailing: Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
