import 'package:jahiz/features/profile/domain/entities/profile_details.dart';

class ProfileDetailsModel extends ProfileDetails {
  const ProfileDetailsModel(
      {required super.firstName,
      required super.middleName,
      required super.lastName,
      required super.email,
      required super.mobileNo,
      required super.gender,
      required super.enabled
      });

  factory ProfileDetailsModel.fromJson(dynamic json) {
    return ProfileDetailsModel(
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        email: json['email'],
        mobileNo: json['mobile_no'],
        gender: json['gender'],
        enabled: json['is_enabled']
        );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['middle_name'] = middleName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['mobile_no'] = mobileNo;
    map['gender'] = gender;
    map['enabled'] = enabled;
    return map;
  }
}
