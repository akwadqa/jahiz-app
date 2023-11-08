import 'city_model.dart';
import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel(
      {required super.addressId,
      required super.addressTitle,
      required super.streetNo,
      required super.buildingNo,
      required super.city,
      required super.akdZoneNumber,
      required super.isShippingAddress,
      required super.akdLongitude,
      required super.akdAltitude,
      required super.phone});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        addressId: json['address_id'],
        addressTitle: json['address_title'],
        streetNo: json['street_no'],
        buildingNo: json['building_no'],
        city: CityModel.fromJson(json['city']),
        akdZoneNumber: json['akd_zone_number'],
        isShippingAddress: json['is_shipping_address'],
        akdLongitude: json['akd_longitude'],
        akdAltitude: json['akd_altitude'],
        phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressId != null) {
      map['address_id'] = addressId;
    }
    map['address_title'] = addressTitle;
    map['street_no'] = streetNo;
    map['building_no'] = buildingNo;
    map['city'] = (city as CityModel).cityId;
    map['akd_zone_number'] = akdZoneNumber;
    map['is_shipping_address'] = isShippingAddress;
    map['akd_longitude'] = akdLongitude;
    map['akd_altitude'] = akdAltitude;
    map['phone'] = phone;
    return map;
  }
}
