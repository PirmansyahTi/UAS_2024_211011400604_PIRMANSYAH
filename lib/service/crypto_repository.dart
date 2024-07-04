// service/crypto_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'crypto.dart';

class CryptoRepository {
  final String apiUrl = 'https://api.coinlore.net/api/tickers/';

  Future<List<Crypto>> fetchCryptos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List cryptos = data['data'];
      return cryptos.map((crypto) => Crypto.fromJson(crypto)).toList();
    } else {
      throw Exception('Failed to load cryptos');
    }
  }
}
