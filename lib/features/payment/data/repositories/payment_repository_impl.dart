import 'package:dartz/dartz.dart';

import 'package:jahiz/core/error/failures.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PaymentRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    if (await _networkInfo.isConnected) {
      try {
        final List<PaymentMethod> paymentMethods =
            (await _remoteDataSource.getPaymentMethods()).cast<PaymentMethod>();
        return Right(paymentMethods);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
