part of 'profile_details_cubit.dart';

sealed class ProfileDetailsState extends Equatable {
  const ProfileDetailsState();

  @override
  List<Object> get props => [];
}

final class ProfileDetailsInitial extends ProfileDetailsState {}

final class ProfileDetailsLoading extends ProfileDetailsState {}

final class ProfileDetailsLoaded extends ProfileDetailsState {
  final ProfileDetails profileDetails;

  const ProfileDetailsLoaded(this.profileDetails);

  @override
  List<Object> get props => [profileDetails];
}

final class ProfileDetailsError extends ProfileDetailsState {
  final String message;

  const ProfileDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
