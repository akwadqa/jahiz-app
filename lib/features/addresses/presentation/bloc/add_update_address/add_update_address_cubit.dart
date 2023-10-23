import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jahiz/features/addresses/domain/entities/address.dart';

import '../../../../../core/shared_functions.dart';
import '../../../domain/entities/city.dart';
import '../../../domain/usecases/add_update_address.dart';

part 'add_update_address_state.dart';

enum AddressType {
  home(name: 'Home'),
  office(name: 'Office'),
  apartment(name: 'Apartment');

  final String name;

  const AddressType({required this.name});
}

class AddUpdateAddressCubit extends Cubit<AddUpdateAddressState> {
  AddUpdateAddressCubit(this._addUpdateAddressUseCase)
      : super(AddUpdateAddressInitial());

  final AddUpdateAddressUseCase _addUpdateAddressUseCase;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  AddressType? _addressType;
  String? _area;
  String? _buildingNameOrNumber;
  String? _streetNameOrNumber;
  City? _city;
  bool? _isDefaultAddress = false;
  String? _receiverPhoneNumber;

  String? Function(String?)? validator(BuildContext context) =>
      SharedFunctions.requiredValidator(context);

  String? Function(String?)? phoneNumberValidator(BuildContext context) =>
      SharedFunctions.phoneNumberValidator(context);

  void onAddressTypeSelected(AddressType value) => _addressType = value;
  void onAreaSaved(String? value) => _area = value;
  void onBuildingNameOrNumberSaved(String? value) =>
      _buildingNameOrNumber = value;
  void onStreetNameOrNumberSaved(String? value) => _streetNameOrNumber = value;
  void onCityIdSaved(City? value) => _city = value;
  void onIsDefaultAddressSaved(bool? value) => _isDefaultAddress = value;
  void onReceiverPhoneNumberSaved(String? value) =>
      _receiverPhoneNumber = value;

  Future<void> submit(LatLng latLng, [String? addressId]) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Address address = Address(
          addressId: addressId,
          addressTitle: _addressType!.name,
          streetNo: _streetNameOrNumber!,
          buildingNo: _buildingNameOrNumber!,
          city: _city!,
          akdZoneNumber: _area,
          isShippingAddress: _isDefaultAddress! ? 1 : 0,
          akdLongitude: latLng.longitude.toString(),
          akdAltitude: latLng.latitude.toString(),
          phone: _receiverPhoneNumber!);
      emit(AddUpdateAddressLoading());
      final failureOrAddress = await _addUpdateAddressUseCase(address);
      failureOrAddress.fold(
          (failure) => emit(AddUpdateAddressError(message: failure.message)),
          (address) => emit(AddUpdateAddressLoaded(address: address)));
    }
  }
}
