import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/sales_order/sales_order.dart';
import '../repositories/orders_repository.dart';

class GetSalesOrdersUseCase {
  final OrdersRepository _repository;

  GetSalesOrdersUseCase(this._repository);

  Future<Either<Failure, AppResponse<List<SalesOrder>>>> call(
      [int? page]) async {
    return await _repository.getSalesOrders(page);
  }
}
