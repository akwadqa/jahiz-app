import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/orders/domain/entities/sales_order_details/sales_order_details.dart';
import 'package:jahiz/features/orders/domain/repositories/orders_repository.dart';

class GetSalesOrderDetailsUseCase {
  final OrdersRepository _repository;

  GetSalesOrderDetailsUseCase(this._repository);

  Future<Either<Failure, SalesOrderDetails>> call(String orderId) async =>
      await _repository.getSalesOrderDetails(orderId);
}
