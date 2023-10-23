import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/addresses_repository.dart';

class AddUpdateAddressUseCase {
  final AddressesRepository _addressesRepository;

  AddUpdateAddressUseCase(this._addressesRepository);

  Future<Either<Failure, Address>> call(Address address) async {
    return await _addressesRepository.addUpdateAddress(address: address);
  }
}
