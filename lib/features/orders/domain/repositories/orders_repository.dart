import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/sales_order/sales_order.dart';
import '../entities/sales_order_details/sales_order_details.dart';

abstract class OrdersRepository {
  Future<Either<Failure, AppResponse<List<SalesOrder>>>> getSalesOrders(
      [int? page]);

  Future<Either<Failure, SalesOrderDetails>> getSalesOrderDetails(
      String orderId);
}
