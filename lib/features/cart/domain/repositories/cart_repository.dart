import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart?>> getCart();
  Future<Either<Failure, Cart?>> updateCart(Cart cart);
}
