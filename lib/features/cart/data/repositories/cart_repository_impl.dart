import 'package:dartz/dartz.dart';

import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/cart/data/datasources/cart_remote_data_source.dart';

import 'package:jahiz/features/cart/domain/entities/cart.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final NetworkInfo _networkInfo;
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._networkInfo, this._remoteDataSource);
  @override
  Future<Either<Failure, Cart?>> getCart() async {
    return await _handelCartResponse(() => _remoteDataSource.getCart());
  }

  @override
  Future<Either<Failure, Cart?>> updateCart(Cart cart) async {
    return await _handelCartResponse(
        () => _remoteDataSource.updateCart(cart.toModel()));
  }

  Future<Either<Failure, Cart?>> _handelCartResponse(
      Future<Cart?> Function() function) async {
    if (await _networkInfo.isConnected) {
      try {
        Cart? cart = await function();
        return Right(cart);
      } catch (e, stackTrace) {
        return Left(ServerFailure(e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
