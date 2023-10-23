part of 'get_addresses_cubit.dart';

abstract class GetAddressesState extends Equatable {
  const GetAddressesState();
}

class GetAddressesInitial extends GetAddressesState {
  @override
  List<Object> get props => [];
}

class GetAddressesLoading extends GetAddressesState {
  @override
  List<Object> get props => [];
}

class GetAddressesLoaded extends GetAddressesState {
  final List<Address> addresses;

  const GetAddressesLoaded(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class GetAddressesEmpty extends GetAddressesState {
  @override
  List<Object> get props => [];
}

class GetAddressesError extends GetAddressesState {
  final String message;

  const GetAddressesError(this.message);

  @override
  List<Object> get props => [message];
}
