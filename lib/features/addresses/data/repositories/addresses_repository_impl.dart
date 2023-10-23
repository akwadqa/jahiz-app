import 'package:dartz/dartz.dart';
import 'package:jahiz/features/addresses/domain/entities/address.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/addresses_repository.dart';
import '../datasources/addresses_remote_data_source.dart';

class AddressesRepositoryImpl implements AddressesRepository {
  final AddressesRemoteDataSource remoteDataSource;
  final NetworkInfo _networkInfo;

  AddressesRepositoryImpl(this.remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getCities();
        return Right(response.data);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Address>> addUpdateAddress(
      {required Address address}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.addUpdateAddress(
            addressModel: address.toModel());
        return Right(response.data);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAddresses();
        return Right(response.data);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
