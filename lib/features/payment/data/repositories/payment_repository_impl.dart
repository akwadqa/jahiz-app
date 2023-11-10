import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';

import '../../../../core/error/failures.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';

class PaymentRepositoryImpl extends NetworkOperationHandler
    implements PaymentRepository {
  final PaymentRemoteDataSource _remoteDataSource;

  PaymentRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    return await handleNetworkOperation<List<PaymentMethod>>(() async {
      final response = await _remoteDataSource.getPaymentMethods();
      return response;
    });
  }
}
