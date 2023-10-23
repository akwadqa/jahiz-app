import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _repository;

  GetCartUseCase(this._repository);

  Future<Either<Failure, Cart?>> call() async => await _repository.getCart();
}
