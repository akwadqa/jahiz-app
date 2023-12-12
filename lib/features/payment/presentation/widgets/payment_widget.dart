import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jahiz/core/gen/fonts.gen.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../application/payment_service.dart';
import '../../../../generated/l10n.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../domain/entities/payment_method.dart';

Future<dynamic> showPaymentBottomSheet(
    {required BuildContext context,
    required PaymentMethod paymentMethod,
    required double total}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) =>
          PaymentWidget(paymentMethod: paymentMethod, total: total));
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget(
      {Key? key, required this.paymentMethod, required this.total})
      : super(key: key);

  final PaymentMethod paymentMethod;
  final double total;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  late MFCardPaymentView _paymentCardView;
  late PaymentService _paymentService;

  @override
  void initState() {
    _paymentService = PaymentService(
        paymentMethod: widget.paymentMethod, total: widget.total);
    _paymentService.initiateCardSession();
    super.initState();
  }

  MFCardViewStyle _cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.input?.inputMargin = 5;
    cardViewStyle.input?.fontFamily = FontFamily.qatar;
    cardViewStyle.input?.borderRadius = 5;
    cardViewStyle.input?.borderWidth = 1;
    cardViewStyle.input?.borderColor = Theme.of(context).primaryColor.value;
    cardViewStyle.input?.inputHeight =
        Theme.of(context).inputDecorationTheme.constraints?.maxHeight;
    cardViewStyle.input?.color = Theme.of(context).primaryColor.value;
    return cardViewStyle;
  }

  @override
  Widget build(BuildContext context) {
    _paymentCardView = MFCardPaymentView(cardViewStyle: _cardViewStyle());
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: AppBottomSheetSkeleton(
          title: S.of(context).paymentMethod,
          content: _paymentCardView,
          submitButton: ElevatedButton(
            onPressed: () {
              _paymentService.payWithCard(
                  paymentCardView: _paymentCardView,
                  onSuccess: () => context.popRoute(true),
                  onFail: () => context.popRoute(false));
            },
            child: Text(S.of(context).confirm),
          )),
    );
  }
}
