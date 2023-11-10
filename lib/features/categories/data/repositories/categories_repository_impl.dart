import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/error/failures.dart';
import '../datasources/categories_remote_data_source.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../../../core/network/network_info.dart';

class CategoriesRepositoryImpl extends NetworkOperationHandler implements CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoriesRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, Category>> getCategories(String category) async {
    return await handleNetworkOperation<Category>(() async {
      final response = await _remoteDataSource.getCategories(category);
      return response;
    });
  }
}
