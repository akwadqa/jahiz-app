import 'package:flutter/material.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/features/payment/domain/entities/payment_method.dart';
import 'package:jahiz/injection_container.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class PaymentService {
  final PaymentMethod paymentMethod;
  final double total;

  PaymentService({required this.paymentMethod, required this.total});

  Future<void> initiatePayment({
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    _setupMyFatoorah();

    try {
      await MFSDK.initiatePayment(
          _createInitiatePaymentRequest(), _getLanguage());
      _processPayment(onSuccess, onFail);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> initiateCardSession({
    Function(String bin)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    _setupMyFatoorah();
    await MFSDK
        .initiateSession(MFInitiateSessionRequest(), (bin) {
          debugPrint(bin);
        })
        .then((value) => {
              debugPrint(value.toString()),
            })
        .catchError((error) => {debugPrint(error.message)});
  }

  Future<void> payWithCard({
    required MFCardPaymentView paymentCardView,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    await paymentCardView
        .pay(_createExecutePaymentRequest(), MFLanguage.ENGLISH, (invoiceId) {
          debugPrint(invoiceId);
        })
        .then((value) => onSuccess())
        .catchError((error) => {debugPrint(error.toString()), onFail()});
  }

  void _setupMyFatoorah() {
    MFSDK.init(paymentMethod.apiToken!, MFCountry.QATAR, MFEnvironment.TEST);
  }

  MFInitiatePaymentRequest _createInitiatePaymentRequest() {
    return MFInitiatePaymentRequest(currencyIso: MFCurrencyISO.QATAR_QAR);
  }

  MFExecutePaymentRequest _createExecutePaymentRequest([int? paymentMethodId]) {
    return MFExecutePaymentRequest(
      paymentMethodId: paymentMethodId,
      invoiceValue: total,
    );
  }

  int _getPaymentMethodId() {
    return int.parse(paymentMethod.myfatoorahPaymentId!);
  }

  String _getLanguage() {
    String selectedLanguageCode = getIt<SelectedLanguageCubit>().state;
    return selectedLanguageCode == 'en'
        ? MFLanguage.ENGLISH
        : MFLanguage.ARABIC;
  }

  void _processPayment(
    VoidCallback onSuccess,
    VoidCallback onFail,
  ) {
    MFSDK
        .executePayment(
      _createExecutePaymentRequest(_getPaymentMethodId()),
      _getLanguage(),
      (String invoiceId) {},
    )
        .then((value) {
      onSuccess();
    }).catchError((error) {
      onFail();
    });
  }
}
