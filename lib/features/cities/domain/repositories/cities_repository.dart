import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/cities/domain/entities/city.dart';

abstract class CitiesRepository {
  Future<Either<Failure, List<City>>> getCities();
}