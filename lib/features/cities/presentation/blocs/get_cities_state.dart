part of 'get_cities_cubit.dart';

abstract class GetCitiesState extends Equatable {
  const GetCitiesState();
}

class GetCitiesInitial extends GetCitiesState {
  @override
  List<Object> get props => [];
}

class GetCitiesLoading extends GetCitiesState {
  @override
  List<Object> get props => [];
}

class GetCitiesLoaded extends GetCitiesState {
  final List<City> cities;
  final City? selectedCity;

  const GetCitiesLoaded(this.cities, this.selectedCity);

  @override
  List<Object?> get props => [cities, selectedCity];
}

class GetCitiesError extends GetCitiesState {
  final String errorMessage;

  const GetCitiesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
