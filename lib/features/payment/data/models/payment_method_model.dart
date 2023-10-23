import 'package:jahiz/core/shared_functions.dart';

import '../../domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel(
      {required super.paymentGateway,
      required super.paymentMethodTitle,
      required super.isOffline,
      required super.supplierCode,
      required super.isEmbedded,
      required super.myfatoorahPaymentId,
      required super.testMode,
      required super.icon,
      required super.apiToken,
      required super.paymentSuccessUrl,
      required super.paymentFailUrl,
      required super.description});

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      paymentGateway: json['payment_gateway'],
      paymentMethodTitle: json['payment_method_title'],
      isOffline: json['is_offline'],
      supplierCode: json['supplier_code'],
      isEmbedded: json['is_embedded'],
      myfatoorahPaymentId: json['myfatoorah_payment_id'],
      testMode: json['test_mode'],
      icon: SharedFunctions.getImageUrl(json['icon']),
      apiToken: json['api_token'],
      paymentSuccessUrl: json['payment_success_url'],
      paymentFailUrl: json['payment_fail_url'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_gateway'] = paymentGateway;
    map['payment_method_title'] = paymentMethodTitle;
    map['is_offline'] = isOffline;
    map['supplier_code'] = supplierCode;
    map['is_embedded'] = isEmbedded;
    map['myfatoorah_payment_id'] = myfatoorahPaymentId;
    map['test_mode'] = testMode;
    map['icon'] = icon;
    map['api_token'] = apiToken;
    map['payment_success_url'] = paymentSuccessUrl;
    map['payment_fail_url'] = paymentFailUrl;
    map['description'] = description;
    return map;
  }
}
