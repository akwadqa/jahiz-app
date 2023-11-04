import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/orders_repository.dart';

class PlaceOrderUseCase {
  final OrdersRepository _repository;

  PlaceOrderUseCase(this._repository);

  Future<Either<Failure, String>> call(
          String quotationId, int? isSuccess) async =>
      await _repository.placeOrder(quotationId, isSuccess);
}
