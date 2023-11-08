import 'package:dartz/dartz.dart';
import '../entities/address.dart';

import '../../../../core/error/failures.dart';
import '../repositories/addresses_repository.dart';

class GetAddressesUseCase {
  final AddressesRepository _addressesRepository;

  GetAddressesUseCase(this._addressesRepository);

  Future<Either<Failure, List<Address>>> call() async =>
      await _addressesRepository.getAddresses();
}
