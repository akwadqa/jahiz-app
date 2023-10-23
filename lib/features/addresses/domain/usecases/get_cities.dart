import 'package:dartz/dartz.dart';
import 'package:jahiz/features/addresses/domain/entities/city.dart';
import '../../../../core/error/failures.dart';
import '../repositories/addresses_repository.dart';

class GetCitiesUseCase {
  final AddressesRepository _addressesRepository;

  GetCitiesUseCase(this._addressesRepository);

  Future<Either<Failure, List<City>>> call() async =>
      await _addressesRepository.getCities();
}
