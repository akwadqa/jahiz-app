import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/core/widgets/app_bottom_sheet.dart';
import 'package:jahiz/features/orders/presentaion/bloc/place_order/place_order_cubit.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../domain/entities/payment_method.dart';

Future<dynamic> showPaymentBottomSheet(
    {required BuildContext context,
    required PaymentMethod paymentMethod,
    required String qutationId,
    required double total,
    required VoidCallback onFailedPayment}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => PaymentWidget(
          paymentMethod: paymentMethod,
          qutationId: qutationId,
          total: total,
          onFailedPayment: onFailedPayment));
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget(
      {Key? key,
      required this.paymentMethod,
      required this.qutationId,
      required this.total,
      required this.onFailedPayment})
      : super(key: key);

  final PaymentMethod paymentMethod;
  final String qutationId;
  final double total;
  final VoidCallback onFailedPayment;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final _paymentCardView = MFCardPaymentView();

  @override
  void initState() {
    MFSDK.init(
        widget.paymentMethod.apiToken!, MFCountry.QATAR, MFEnvironment.TEST);
    _initiateSession();
    _initiatePaymentRequest();
    super.initState();
  }

  void _initiateSession() async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();
    await MFSDK
        .initiateSession(initiateSessionRequest, (bin) {
          debugPrint(bin);
        })
        .then((value) => {
              debugPrint(value.toString()),
            })
        .catchError((error) => {debugPrint(error.message)});
  }

  Future<void> _initiatePaymentRequest() async {
    final selectedLanguageCode = context.read<SelectedLanguageCubit>().state;
    MFInitiatePaymentRequest request =
        MFInitiatePaymentRequest(currencyIso: MFCurrencyISO.QATAR_QAR);
    await MFSDK
        .initiatePayment(
            request,
            selectedLanguageCode == 'en'
                ? MFLanguage.ENGLISH
                : MFLanguage.ARABIC)
        .then((value) => debugPrint(value.toJson().toString()))
        .catchError((error) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error!.message!))));
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
        title: S.of(context).paymentMethod,
        content: _paymentCardView,
        submitButton: ElevatedButton(
          onPressed: () async {
            final selectedLanguageCode =
                context.read<SelectedLanguageCubit>().state;
            String apiLanguage = selectedLanguageCode == 'en'
                ? MFLanguage.ENGLISH
                : MFLanguage.ARABIC;
            var request = MFExecutePaymentRequest(invoiceValue: widget.total);
            await _paymentCardView
                .pay(request, apiLanguage, (invoiceId) {})
                .then((value) async {
              context.read<PlaceOrderCubit>().placeOrder(widget.qutationId, 1);
            }).catchError((error) {
              print((error as MFError).message);
              widget.onFailedPayment;
            });
          },
          child: Text(S.of(context).confirm),
        ));
  }
}
