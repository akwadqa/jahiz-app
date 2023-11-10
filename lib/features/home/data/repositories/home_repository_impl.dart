import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/home_remote_data_source.dart';
import '../../../products/domain/repositories/home_repository.dart';

import '../../domain/entities/home_block.dart';

class HomeRepositoryImpl extends NetworkOperationHandler
    implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  HomeRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, List<HomeBlock>>> getHomeBlocks() async {
    return await handleNetworkOperation<List<HomeBlock>>(() async {
      final response = await _remoteDataSource.getHomeBlocks();
      return response;
    });
  }
}
