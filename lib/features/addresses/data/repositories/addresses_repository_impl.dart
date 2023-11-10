import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../domain/entities/address.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/addresses_repository.dart';
import '../datasources/addresses_remote_data_source.dart';

class AddressesRepositoryImpl extends NetworkOperationHandler
    implements AddressesRepository {
  final AddressesRemoteDataSource _remoteDataSource;
  AddressesRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, Address>> addUpdateAddress(
      {required Address address}) async {
    return await handleNetworkOperation<Address>(() async {
      final response = await _remoteDataSource.addUpdateAddress(
            addressModel: address.toModel());
        return response.data;
    });
  }

  @override
  Future<Either<Failure, List<Address>>> getAddresses() async {
    return await handleNetworkOperation<List<Address>>(() async {
      final response = await _remoteDataSource.getAddresses();
      return response.data;
    });
  }
}
