import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final String customerId;
  final String company;
  final String companyWhatsappNumber;
  final String privacyPolicy;
  final String username;
  final String fullName;
  final String mobileNo;
  final String? companyName;

  const AppSettings(
      {required this.customerId,
      required this.company,
      required this.companyWhatsappNumber,
      required this.privacyPolicy,
      required this.username,
      required this.fullName,
      required this.mobileNo,
      required this.companyName});

  AppSettings copyWith(
      {String? customerId,
      String? company,
      String? companyWhatsappNumber,
      String? privacyPolicy,
      String? username,
      String? fullName,
      String? mobileNo,
      String? companyName}) {
    return AppSettings(
      customerId: customerId ?? this.customerId,
      company: company ?? this.company,
      companyWhatsappNumber:
          companyWhatsappNumber ?? this.companyWhatsappNumber,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      mobileNo: mobileNo ?? this.mobileNo,
      companyName: companyName ?? this.companyName,
    );
  }

  @override
  List<Object?> get props => [
        customerId,
        company,
        companyWhatsappNumber,
        privacyPolicy,
        username,
        fullName,
        mobileNo,
        companyName,
      ];
}
