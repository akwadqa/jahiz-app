import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/features/cities/domain/entities/city.dart';
import 'package:jahiz/features/cities/domain/usecases/get_cities.dart';

part 'get_cities_state.dart';

class GetCitiesCubit extends Cubit<GetCitiesState> {
  final GetCitiesUseCase _getCitiesUseCase;

  GetCitiesCubit(this._getCitiesUseCase) : super(GetCitiesInitial()) {
    getCities();
  }

  Future<void> getCities() async {
    emit(GetCitiesLoading());
    final failureOrCities = await _getCitiesUseCase();
    failureOrCities.fold((failure) => emit(GetCitiesError(failure.message)),
        (cities) => emit(GetCitiesLoaded(cities, null)));
  }

  void onCitySelected(City city) {
    emit(GetCitiesLoaded((state as GetCitiesLoaded).cities, city));
  }
}
