import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';

import '../../../../core/error/failures.dart';
import '../datasources/cart_remote_data_source.dart';

import '../../domain/entities/cart.dart';

import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends NetworkOperationHandler
    implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(super.networkInfo, this._remoteDataSource);
  @override
  Future<Either<Failure, Cart?>> getCart() async {
    return await handleNetworkOperation<Cart?>(() async {
      Cart? cart = await _remoteDataSource.getCart();
      return cart;
    });
  }

  @override
  Future<Either<Failure, Cart?>> updateCart(Cart cart) async {
    return await handleNetworkOperation<Cart?>(() async {
      Cart? cartResponse = await _remoteDataSource.updateCart(cart.toModel());
      return cartResponse;
    });
  }
}
