import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/sales_order_details/sales_order_details.dart';
import '../repositories/orders_repository.dart';

class GetSalesOrderDetailsUseCase {
  final OrdersRepository _repository;

  GetSalesOrderDetailsUseCase(this._repository);

  Future<Either<Failure, SalesOrderDetails>> call(String orderId) async =>
      await _repository.getSalesOrderDetails(orderId);
}
