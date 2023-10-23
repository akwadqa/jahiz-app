import 'package:equatable/equatable.dart';

class ProfileDetails extends Equatable {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String mobileNo;
  final bool? gender;
  final int? enabled;

  const ProfileDetails(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.mobileNo,
      required this.gender,
      required this.enabled
      });

  ProfileDetails copyWith(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? email,
      String? mobileNo,
      bool? gender,
      int? enabled
      }) {
    return ProfileDetails(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        mobileNo: mobileNo ?? this.mobileNo,
        gender: gender ?? this.gender,
        enabled: enabled ?? this.enabled
        );
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        email,
        mobileNo,
        gender,
        enabled
      ];
}
