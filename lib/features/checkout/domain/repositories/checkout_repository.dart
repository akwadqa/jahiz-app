import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, String>> placeOrder(
      String quotationId, int? isSuccess);
}
