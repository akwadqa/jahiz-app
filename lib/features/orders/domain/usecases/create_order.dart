import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/orders_repository.dart';
import '../../domain/entities/order.dart' as o;

class CreateOrderUseCase {
  final OrdersRepository _repository;

  CreateOrderUseCase(this._repository);

  Future<Either<Failure, o.Order>> call(
          String quotationId, String paymentMethodId) async =>
      await _repository.createOrder(quotationId, paymentMethodId);
}
