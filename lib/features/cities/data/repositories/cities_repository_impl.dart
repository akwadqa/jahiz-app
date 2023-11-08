import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/exception.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/core/network/network_info.dart';
import 'package:jahiz/features/cities/data/datasources/cities_remote_data_source.dart';
import 'package:jahiz/features/cities/domain/entities/city.dart';
import 'package:jahiz/features/cities/domain/repositories/cities_repository.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CitiesRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getCities();
        return Right(response.data);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}