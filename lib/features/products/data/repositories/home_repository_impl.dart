import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../home/data/datasources/home_remote_data_source.dart';
import '../../domain/repositories/home_repository.dart';

import '../../../home/domain/entities/home_block.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  HomeRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<HomeBlock>>> getHomeBlocks() async {
    if (await _networkInfo.isConnected) {
      try {
        List<HomeBlock> homeBlocks = await _remoteDataSource.getHomeBlocks();
        return Right(homeBlocks);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
