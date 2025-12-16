import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/exception.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/core/network/network_info.dart';

class NetworkOperationHandler {
  final NetworkInfo networkInfo;

  NetworkOperationHandler(this.networkInfo);

  Future<Either<Failure, T>> handleNetworkOperation<T>(Future<T> Function() operation) async {
    // if (await networkInfo.isConnected) {
      try {
        T result = await operation();
        return Right(result);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    // } else {
    //   return Left(OfflineFailure());
    // }
  }
}