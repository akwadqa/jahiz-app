import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../../domain/entities/sales_order/sales_order.dart';
import '../../domain/entities/sales_order_details/sales_order_details.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl extends NetworkOperationHandler
    implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, AppResponse<List<SalesOrder>>>> getSalesOrders(
      [int? page]) async {
    return await handleNetworkOperation<AppResponse<List<SalesOrder>>>(
        () async {
      final response = await _remoteDataSource.getSalesOrders(page);
      return response;
    });
  }

  @override
  Future<Either<Failure, SalesOrderDetails>> getSalesOrderDetails(
      String orderId) async {
    return await handleNetworkOperation<SalesOrderDetails>(() async {
      final response = await _remoteDataSource.getSalesOrderDetails(orderId);
      return response;
    });
  }
}
