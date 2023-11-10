import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../domain/entities/detailed_product.dart';
import '../../../home/domain/repositories/products_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/products_remote_data_source.dart';

class ProductsRepositoryImpl extends NetworkOperationHandler
    implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductsRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, DetailedProduct>> getDetailedProduct(
      String productId) async {
    return await handleNetworkOperation<DetailedProduct>(() async {
      final response = await _remoteDataSource.getDetailedProduct(productId);
      return response;
    });
  }
}
