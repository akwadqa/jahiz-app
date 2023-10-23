import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/payment/domain/repositories/payment_repository.dart';

import '../entities/payment_method.dart';

class GetPaymentMethodsUseCase {
  final PaymentRepository _repository;

  GetPaymentMethodsUseCase(this._repository);

  Future<Either<Failure, List<PaymentMethod>>> call() async =>
      await _repository.getPaymentMethods();
}
