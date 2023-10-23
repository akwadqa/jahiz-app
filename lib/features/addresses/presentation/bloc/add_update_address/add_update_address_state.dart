part of 'add_update_address_cubit.dart';

abstract class AddUpdateAddressState extends Equatable {
  const AddUpdateAddressState();
}

class AddUpdateAddressInitial extends AddUpdateAddressState {
  @override
  List<Object> get props => [];
}

class AddUpdateAddressLoading extends AddUpdateAddressState {
  @override
  List<Object> get props => [];
}

class AddUpdateAddressLoaded extends AddUpdateAddressState {
  final Address address;

  const AddUpdateAddressLoaded({required this.address});

  @override
  List<Object> get props => [address];
}

class AddUpdateAddressError extends AddUpdateAddressState {
  final String message;

  const AddUpdateAddressError({required this.message});

  @override
  List<Object> get props => [message];
}
