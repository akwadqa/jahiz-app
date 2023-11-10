import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/checkout_remote_data_source.dart';
import '../../domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl extends NetworkOperationHandler
    implements CheckoutRepository {
  final CheckoutRemoteDataSource _remoteDataSource;

  CheckoutRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> placeOrder(
      String quotationId, int? isSuccess) async {
    return await handleNetworkOperation<String>(() async {
      final response =
          await _remoteDataSource.placeOrder(quotationId, isSuccess);
      return response;
    });
  }
}
