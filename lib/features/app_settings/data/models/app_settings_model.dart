import '../../domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required super.customerId,
    required super.company,
    required super.companyWhatsappNumber,
    required super.privacyPolicy,
    required super.username,
    required super.fullName,
    required super.mobileNo,
    required super.companyName,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      customerId: json['customer_id'],
      company: json['company'],
      companyWhatsappNumber: json['company_whatsapp_number'],
      privacyPolicy: json['privacy_policy'],
      username: json['username'],
      fullName: json['full_name'],
      mobileNo: json['mobile_no'],
      companyName: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = customerId;
    map['company'] = company;
    map['company_whatsapp_number'] = companyWhatsappNumber;
    map['privacy_policy'] = privacyPolicy;
    map['username'] = username;
    map['full_name'] = fullName;
    map['mobile_no'] = mobileNo;
    map['company_name'] = companyName;
    return map;
  }
}
