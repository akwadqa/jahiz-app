import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String paymentGateway;
  final String paymentMethodTitle;
  final int? isOffline;
  final String? supplierCode;
  final int? isEmbedded;
  final String? myfatoorahPaymentId;
  final int? testMode;
  final String icon;
  final String? apiToken;
  final String? paymentSuccessUrl;
  final String? paymentFailUrl;
  final String description;

  const PaymentMethod(
      {required this.paymentGateway,
      required this.paymentMethodTitle,
      required this.isOffline,
      required this.supplierCode,
      required this.isEmbedded,
      required this.myfatoorahPaymentId,
      required this.testMode,
      required this.icon,
      required this.apiToken,
      required this.paymentSuccessUrl,
      required this.paymentFailUrl,
      required this.description});

  PaymentMethod copyWith({
    String? paymentGateway,
    String? paymentMethodTitle,
    int? isOffline,
    String? supplierCode,
    int? isEmbedded,
    String? myfatoorahPaymentId,
    int? testMode,
    String? icon,
    String? apiToken,
    String? paymentSuccessUrl,
    String? paymentFailUrl,
    String? description,
  }) {
    return PaymentMethod(
      paymentGateway: paymentGateway ?? this.paymentGateway,
      paymentMethodTitle: paymentMethodTitle ?? this.paymentMethodTitle,
      isOffline: isOffline ?? this.isOffline,
      supplierCode: supplierCode ?? this.supplierCode,
      isEmbedded: isEmbedded ?? this.isEmbedded,
      myfatoorahPaymentId: myfatoorahPaymentId ?? this.myfatoorahPaymentId,
      testMode: testMode ?? this.testMode,
      icon: icon ?? this.icon,
      apiToken: apiToken ?? this.apiToken,
      paymentSuccessUrl: paymentSuccessUrl ?? this.paymentSuccessUrl,
      paymentFailUrl: paymentFailUrl ?? this.paymentFailUrl,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        paymentGateway,
        paymentMethodTitle,
        isOffline,
        supplierCode,
        isEmbedded,
        myfatoorahPaymentId,
        testMode,
        icon,
        apiToken,
        paymentSuccessUrl,
        paymentFailUrl,
        description,
      ];
}
