import '../../domain/entities/auth.dart';
import '../../../profile/data/models/profile_details_model.dart';

class AuthModel extends Auth {
  const AuthModel({required super.token, required super.profileDetails});

  factory AuthModel.fromJson(dynamic json) {
    return AuthModel(
        token: json['token'],
        profileDetails: ProfileDetailsModel.fromJson(json['profile_details']));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['profile_details'] = (profileDetails as ProfileDetailsModel).toJson();
    return map;
  }
}
