import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/address.dart';
import '../../../domain/usecases/get_addresses.dart';

part 'get_addresses_state.dart';

class GetAddressesCubit extends Cubit<GetAddressesState> {
  GetAddressesCubit(this._getAddressesUseCase) : super(GetAddressesInitial());

  final GetAddressesUseCase _getAddressesUseCase;

  Future<void> getAddresses() async {
    emit(GetAddressesLoading());
    final result = await _getAddressesUseCase();
    result.fold(
        (failure) => emit(GetAddressesError(failure.message)),
        (addresses) => addresses.isEmpty
            ? emit(GetAddressesEmpty())
            : emit(GetAddressesLoaded(addresses)));
  }
}
