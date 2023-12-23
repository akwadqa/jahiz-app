import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
  late PaymentService _paymentService;
  late MFCardPaymentView _paymentCardView;

  @override
  void initState() {
    _paymentService = PaymentService(
        paymentMethod: widget.paymentMethod, total: widget.total);
    _paymentService.initiateCardSession(
      onSuccess: (sessionResponse) => _paymentCardView.load(sessionResponse, (bin) => null),
    );
    super.initState();
  }

  MFCardViewStyle _cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.input?.inputMargin = 5;
    cardViewStyle.input?.borderRadius = 5;
    cardViewStyle.input?.borderWidth = 1;
    cardViewStyle.input?.borderColor = Theme.of(context).primaryColor.value;
    cardViewStyle.input?.inputHeight =
        Theme.of(context).inputDecorationTheme.constraints?.maxHeight;
    cardViewStyle.input?.color = Theme.of(context).primaryColor.value;
    cardViewStyle.label?.text?.cardNumber = S.of(context).cardNumber;
    cardViewStyle.label?.text?.holderName = S.of(context).cardHolderName;
    cardViewStyle.label?.text?.expiryDate = S.of(context).expiryDate;
    cardViewStyle.label?.text?.securityCode = S.of(context).securityCode;
    cardViewStyle.input?.placeHolder?.cardNumber = S.of(context).number;
    cardViewStyle.input?.placeHolder?.holderName = S.of(context).nameOnCard;
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
