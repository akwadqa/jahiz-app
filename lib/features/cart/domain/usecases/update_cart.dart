import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class UpdateCartUseCase {
  final CartRepository _repository;

  UpdateCartUseCase(this._repository);

  Future<Either<Failure, Cart?>> call(Cart cart) async =>
      await _repository.updateCart(cart);
}
