import 'package:equatable/equatable.dart';
import '../../data/models/address_model.dart';
import '../../../cities/domain/entities/city.dart';

class Address extends Equatable {
  final String? addressId;
  final String addressTitle;
  final String streetNo;
  final String buildingNo;
  final City city;
  final String? akdZoneNumber;
  final int isShippingAddress;
  final String akdLongitude;
  final String akdAltitude;
  final String phone;

  const Address(
      {required this.addressId,
      required this.addressTitle,
      required this.streetNo,
      required this.buildingNo,
      required this.city,
      required this.akdZoneNumber,
      required this.isShippingAddress,
      required this.akdLongitude,
      required this.akdAltitude,
      required this.phone});

  Address copyWith(
      {String? addressId,
      String? addressTitle,
      String? streetNo,
      String? buildingNo,
      City? city,
      String? akdZoneNumber,
      int? isShippingAddress,
      String? akdLongitude,
      String? akdAltitude,
      String? phone}) {
    return Address(
        addressId: addressId ?? this.addressId,
        addressTitle: addressTitle ?? this.addressTitle,
        streetNo: streetNo ?? this.streetNo,
        buildingNo: buildingNo ?? this.buildingNo,
        city: city ?? this.city,
        akdZoneNumber: akdZoneNumber ?? this.akdZoneNumber,
        isShippingAddress: isShippingAddress ?? this.isShippingAddress,
        akdLongitude: akdLongitude ?? this.akdLongitude,
        akdAltitude: akdAltitude ?? this.akdAltitude,
        phone: phone ?? this.phone);
  }

  AddressModel toModel() {
    return AddressModel(
        addressId: addressId,
        addressTitle: addressTitle,
        streetNo: streetNo,
        buildingNo: buildingNo,
        city: city,
        akdZoneNumber: akdZoneNumber,
        isShippingAddress: isShippingAddress,
        akdLongitude: akdLongitude,
        akdAltitude: akdAltitude,
        phone: phone);
  }

  @override
  List<Object?> get props => [
        addressId,
        addressTitle,
        streetNo,
        buildingNo,
        city,
        akdZoneNumber,
        isShippingAddress,
        akdLongitude,
        akdAltitude,
        phone
      ];
}
