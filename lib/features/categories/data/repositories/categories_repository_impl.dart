import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../datasources/categories_remote_data_source.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/categories_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CategoriesRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Category>> getCategories(String category) async {
    if (await _networkInfo.isConnected) {
      try {
        Category nCategory = await _remoteDataSource.getCategories(category);
        return Right(nCategory);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
