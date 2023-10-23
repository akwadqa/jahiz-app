import 'package:equatable/equatable.dart';
import 'package:jahiz/features/profile/domain/entities/profile_details.dart';

class Auth extends Equatable {
  final String token;
  final ProfileDetails profileDetails;

  const Auth({required this.token, required this.profileDetails});

  Auth copyWith({String? token, ProfileDetails? profileDetails}) {
    return Auth(
        token: token ?? this.token,
        profileDetails: profileDetails ?? this.profileDetails);
  }

  @override
  List<Object?> get props => [token, profileDetails];
}
