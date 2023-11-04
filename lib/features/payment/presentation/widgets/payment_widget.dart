import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/core/widgets/app_bottom_sheet.dart';
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
  late MFCardPaymentView _paymentCardView;

  @override
  void initState() {
    MFSDK.init(
        widget.paymentMethod.apiToken!, MFCountry.QATAR, MFEnvironment.TEST);
    _initiateSession();
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

  @override
  Widget build(BuildContext context) {
    _paymentCardView = MFCardPaymentView();
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
              context.popRoute(true);
            }).catchError((error) {
              context.popRoute(false);
            });
          },
          child: Text(S.of(context).confirm),
        ));
  }
}
