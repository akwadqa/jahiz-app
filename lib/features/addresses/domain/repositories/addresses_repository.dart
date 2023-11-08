import 'package:dartz/dartz.dart';
import '../entities/address.dart';
import '../../../../core/error/failures.dart';
import '../entities/city.dart';

abstract class AddressesRepository {
  Future<Either<Failure, List<City>>> getCities();
  Future<Either<Failure, Address>> addUpdateAddress({required Address address});
  Future<Either<Failure, List<Address>>> getAddresses();
}
