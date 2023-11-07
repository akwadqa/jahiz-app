import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, String>> placeOrder(
      String quotationId, int? isSuccess);
}
