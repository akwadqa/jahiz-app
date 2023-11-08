import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../../domain/entities/sales_order/sales_order.dart';
import '../../domain/entities/sales_order_details/sales_order_details.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  OrdersRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AppResponse<List<SalesOrder>>>> getSalesOrders(
      [int? page]) async {
    if (await _networkInfo.isConnected) {
      try {
        final AppResponse<List<SalesOrder>> appResponse =
            await _remoteDataSource.getSalesOrders(page);
        return Right(appResponse);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, SalesOrderDetails>> getSalesOrderDetails(
      String orderId) async {
    if (await _networkInfo.isConnected) {
      try {
        final SalesOrderDetails salesOrderDetails =
            await _remoteDataSource.getSalesOrderDetails(orderId);
        return Right(salesOrderDetails);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
