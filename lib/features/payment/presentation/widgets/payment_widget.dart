import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/core/widgets/app_bottom_sheet.dart';
import 'package:jahiz/features/orders/presentaion/bloc/update_payment_status/update_payment_status_cubit.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../../orders/domain/entities/order.dart';
import '../../domain/entities/payment_method.dart';

Future<dynamic> showPaymentBottomSheet(
    BuildContext context,
    PaymentMethod paymentMethod,
    double total,
    Function(String orderId) onSuccessfulPayment,
    VoidCallback onFailedPayment,
    Order order) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider(
            create: (_) => getIt<UpdatePaymentStatusCubit>(),
            child: PaymentWidget(
                paymentMethod: paymentMethod,
                total: total,
                onSuccessfulPayment: onSuccessfulPayment(order.name),
                onFailedPayment: onFailedPayment,
                order: order),
          ));
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget(
      {Key? key,
      required this.paymentMethod,
      required this.total,
      required this.onSuccessfulPayment,
      required this.onFailedPayment,
      required this.order})
      : super(key: key);

  final PaymentMethod paymentMethod;
  final double total;
  final Function(String orderId) onSuccessfulPayment;
  final VoidCallback onFailedPayment;
  final Order order;

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
    super.initState();
  }

  Future<void> _initiateSession() async {
    final selectedLanguageCode = context.read<SelectedLanguageCubit>().state;
    MFInitiatePaymentRequest request = MFInitiatePaymentRequest(
        currencyIso: MFCurrencyISO.QATAR_QAR);
    await MFSDK
        .initiatePayment(request, selectedLanguageCode == 'en' ? MFLanguage.ENGLISH : MFLanguage.ARABIC)
        .then((value) => debugPrint(value.paymentMethods.toString()))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error!.message!))));
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
        title: S.of(context).paymentMethod,
        content: _paymentCardView,
        submitButton: ElevatedButton(
          onPressed: () {
            pay(
                context,
                widget.paymentMethod,
                widget.total,
                widget.onSuccessfulPayment(widget.order.name),
                widget.onFailedPayment,
                widget.order,
                true,
                _paymentCardView);
          },
          child: Text(S.of(context).confirm),
        ));
  }
}
