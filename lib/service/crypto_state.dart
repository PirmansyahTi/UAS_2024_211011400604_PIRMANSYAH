// service/crypto_state.dart

import 'crypto.dart';

class CryptoState {
  final bool isLoading;
  final bool hasError;
  final List<Crypto> cryptos;

  CryptoState({required this.isLoading, required this.hasError, required this.cryptos});

  factory CryptoState.initial() {
    return CryptoState(isLoading: false, hasError: false, cryptos: []);
  }

  CryptoState copyWith({bool? isLoading, bool? hasError, List<Crypto>? cryptos}) {
    return CryptoState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      cryptos: cryptos ?? this.cryptos,
    );
  }
}
