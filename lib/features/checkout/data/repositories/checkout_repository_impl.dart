import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/checkout_remote_data_source.dart';
import '../../domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CheckoutRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, String>> placeOrder(
      String quotationId, int? isSuccess) async {
    if (await _networkInfo.isConnected) {
      try {
        final String orderId =
            await _remoteDataSource.placeOrder(quotationId, isSuccess);
        return Right(orderId);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
