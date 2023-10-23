import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/orders_repository.dart';

class UpdatePaymentStatusUseCase {
  final OrdersRepository _repository;

  UpdatePaymentStatusUseCase(this._repository);

  Future<Either<Failure, void>> call(
          String orderId,
          String paymentGateway,
          String invoiceId,
          String amount,
          String payerEmail,
          String payerName,
          String currency) async =>
      await _repository.updatePaymentStatus(orderId, paymentGateway, invoiceId,
          amount, payerEmail, payerName, currency);
}
