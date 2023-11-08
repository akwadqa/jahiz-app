import '../../domain/entities/city.dart';

class CityModel extends City {
  const CityModel(
      {required super.cityId, required super.cityName, required super.country});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['city_id'],
      cityName: json['city_name'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': cityId,
      'city_name': cityName,
      'country': country,
    };
  }
}
