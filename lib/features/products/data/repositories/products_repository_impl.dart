import 'package:dartz/dartz.dart';
import 'package:jahiz/features/products/domain/entities/detailed_product.dart';
import 'package:jahiz/features/products/domain/repositories/products_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/products_remote_data_source.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ProductsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, DetailedProduct>> getDetailedProduct(
      String productId) async {
    if (await _networkInfo.isConnected) {
      try {
        DetailedProduct homeBlocks =
            await _remoteDataSource.getDetailedProduct(productId);
        return Right(homeBlocks);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
