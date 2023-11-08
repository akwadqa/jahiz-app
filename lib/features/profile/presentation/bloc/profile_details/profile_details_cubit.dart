import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/profile_details.dart';
import '../../../domain/usecases/get_profile_details.dart';

part 'profile_details_state.dart';

class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  ProfileDetailsCubit(this._getProfileDetailsUserCase)
      : super(ProfileDetailsInitial());

  final GetProfileDetailsUseCase _getProfileDetailsUserCase;

  Future<void> getProfileDetails() async {
    emit(ProfileDetailsLoading());
    final failureOrLoaded = await _getProfileDetailsUserCase();
    failureOrLoaded.fold(
        (failure) => emit(ProfileDetailsError(failure.message)),
        (profileDetails) => emit(ProfileDetailsLoaded(profileDetails)));
  }
}
