import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment_method.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();
}
