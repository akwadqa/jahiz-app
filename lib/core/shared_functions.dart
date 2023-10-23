import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:queen_validators/queen_validators.dart';

import '../features/orders/domain/entities/order.dart';
import '../features/orders/presentaion/bloc/update_payment_status/update_payment_status_cubit.dart';
import '../features/payment/domain/entities/payment_method.dart';
import 'blocs/selected_language_cubit.dart';

abstract class SharedFunctions {
  static String getImageUrl(String imagePath) =>
      '${AppConstants.hostUrl}$imagePath';
  static Color getColor(String hashColor) =>
      Color(int.parse('0xff${hashColor.replaceAll('#', '')}'));
  static String? Function(String?)? requiredValidator(BuildContext context) =>
      qValidator([IsRequired(S.of(context).required)]);
  static String? Function(String?)? phoneNumberValidator(
          BuildContext context) =>
      qValidator([
        IsRequired(S.of(context).required),
        MaxLength(8, S.of(context).mustBeEightDigits),
        MinLength(8, S.of(context).mustBeEightDigits),
        RegExpRule(
            RegExp(r'^([3567])\d+'), S.of(context).qatariPhoneNumberValidator)
      ]);

  static String? Function(String?)? emailValidator(BuildContext context) =>
      qValidator([
        IsRequired(S.of(context).required),
        IsEmail(S.of(context).invalidEmail)
      ]);
}

Future<void> pay(
    BuildContext context,
    PaymentMethod paymentMethod,
    double total,
    Function(String orderId) onSuccessfulPayment,
    VoidCallback onFailedPayment,
    Order order,
    bool isEmbedded,
    [MFCardPaymentView? paymentCardView]) async {
  final selectedLanguageCode = context.read<SelectedLanguageCubit>().state;
  var request = isEmbedded
      ? MFExecutePaymentRequest(invoiceValue: total)
      : MFExecutePaymentRequest(
          paymentMethodId: int.parse(paymentMethod.myfatoorahPaymentId!),
          invoiceValue: total);
  request.customerReference = order.name;
  request.customerName = order.customerName;
  request.customerMobile = order.contactMobile;
  request.customerEmail = order.contactEmail;
  request.displayCurrencyIso = order.currency;
  request.language = selectedLanguageCode;
  request.suppliers = [
    MFSupplier(
        supplierCode: int.parse(paymentMethod.supplierCode!),
        invoiceShare: total)
  ];
  String apiLanguage =
      selectedLanguageCode == 'en' ? MFLanguage.ENGLISH : MFLanguage.ARABIC;
  if (isEmbedded) {
    await paymentCardView!
        .pay(request, apiLanguage, (invoiceId) {})
        .then((value) async {
      await _onPaymentSuccess(
          context, order, paymentMethod, value, total, onSuccessfulPayment);
    }).catchError((error) {
      onFailedPayment();
    });
  } else {
    MFSDK
        .executePayment(request, apiLanguage, (String invoiceId) {})
        .then((value) async {
      await _onPaymentSuccess(
          context, order, paymentMethod, value, total, onSuccessfulPayment);
    }).catchError((error) {
      onFailedPayment();
    });
  }
}

Future<void> _onPaymentSuccess(
    BuildContext context,
    Order order,
    PaymentMethod paymentMethod,
    MFGetPaymentStatusResponse value,
    double total,
    Function(String orderId) onSuccessfulPayment) async {
  await context.read<UpdatePaymentStatusCubit>().updatePaymentStatus(
      order.name,
      paymentMethod.paymentGateway,
      value.invoiceId.toString(),
      total.toString(),
      order.contactEmail,
      order.customerName,
      order.currency);
  onSuccessfulPayment(order.name);
}
