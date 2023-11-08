import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String cityId;
  final String cityName;
  final String country;

  const City(
      {required this.cityId, required this.cityName, required this.country});

  City copyWith({
    String? cityId,
    String? cityName,
    String? country,
  }) {
    return City(
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [cityId, cityName, country];
}
