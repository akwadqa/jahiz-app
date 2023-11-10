import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/core/network/network_info.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import 'package:jahiz/features/cities/data/datasources/cities_remote_data_source.dart';
import 'package:jahiz/features/cities/domain/entities/city.dart';
import 'package:jahiz/features/cities/domain/repositories/cities_repository.dart';

class CitiesRepositoryImpl extends NetworkOperationHandler
    implements CitiesRepository {
  final CitiesRemoteDataSource _remoteDataSource;

  CitiesRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    return await handleNetworkOperation<List<City>>(() async {
      final response = await _remoteDataSource.getCities();
      return response.data;
    });
  }
}
