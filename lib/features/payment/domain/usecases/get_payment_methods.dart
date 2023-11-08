import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/payment_repository.dart';

import '../entities/payment_method.dart';

class GetPaymentMethodsUseCase {
  final PaymentRepository _repository;

  GetPaymentMethodsUseCase(this._repository);

  Future<Either<Failure, List<PaymentMethod>>> call() async =>
      await _repository.getPaymentMethods();
}
