import 'package:dartz/dartz.dart';
import 'package:jahiz/features/checkout/domain/repositories/checkout_repository.dart';

import '../../../../core/error/failures.dart';

class PlaceOrderUseCase {
  final CheckoutRepository _repository;

  PlaceOrderUseCase(this._repository);

  Future<Either<Failure, String>> call(
          String quotationId, int? isSuccess) async =>
      await _repository.placeOrder(quotationId, isSuccess);
}
