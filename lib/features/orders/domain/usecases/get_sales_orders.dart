import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/orders/domain/entities/sales_order/sales_order.dart';
import 'package:jahiz/features/orders/domain/repositories/orders_repository.dart';

class GetSalesOrdersUseCase {
  final OrdersRepository _repository;

  GetSalesOrdersUseCase(this._repository);

  Future<Either<Failure, AppResponse<List<SalesOrder>>>> call(
      [int? page]) async {
    return await _repository.getSalesOrders(page);
  }
}
