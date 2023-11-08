import 'package:dartz/dartz.dart';
import 'package:jahiz/features/cities/domain/repositories/cities_repository.dart';
import '../entities/city.dart';
import '../../../../core/error/failures.dart';

class GetCitiesUseCase {
  final CitiesRepository _citiesRepository;

  GetCitiesUseCase(this._citiesRepository);

  Future<Either<Failure, List<City>>> call() async =>
      await _citiesRepository.getCities();
}
