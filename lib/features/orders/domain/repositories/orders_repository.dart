import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/orders/domain/entities/sales_order/sales_order.dart';
import 'package:jahiz/features/orders/domain/entities/sales_order_details/sales_order_details.dart';
import '../../domain/entities/order.dart' as o;

abstract class OrdersRepository {
  Future<Either<Failure, o.Order>> createOrder(
      String quotationId, String paymentMethodId);

  Future<Either<Failure, void>> updatePaymentStatus(
      String orderId,
      String paymentGateway,
      String invoiceId,
      String amount,
      String payerEmail,
      String payerName,
      String currency);

  Future<Either<Failure, AppResponse<List<SalesOrder>>>> getSalesOrders(
      [int? page]);

  Future<Either<Failure, SalesOrderDetails>> getSalesOrderDetails(String orderId);
}
