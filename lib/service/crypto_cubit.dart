// service/crypto_cubit.dart

import 'package:bloc/bloc.dart';
import 'crypto_state.dart';
import 'crypto_repository.dart';


class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoCubit(this._cryptoRepository) : super(CryptoState.initial());

  void fetchCryptos() async {
    try {
      emit(state.copyWith(isLoading: true));
      final cryptos = await _cryptoRepository.fetchCryptos();
      emit(state.copyWith
      (isLoading: false, cryptos: cryptos, hasError: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
