import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/core/widgets/app_bottom_sheet.dart';
import 'package:jahiz/features/addresses/domain/entities/address.dart';
import 'package:jahiz/features/addresses/presentation/bloc/add_update_address/add_update_address_cubit.dart';
import 'package:jahiz/features/addresses/presentation/bloc/get_addresses/get_addresses_cubit.dart';
import 'package:jahiz/features/addresses/presentation/widgets/address_form_widget.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:queen_validators/queen_validators.dart';

import '../features/orders/domain/entities/order.dart';
import '../features/orders/presentaion/bloc/update_payment_status/update_payment_status_cubit.dart';
import '../features/payment/domain/entities/payment_method.dart';
import 'blocs/selected_language_cubit.dart';

class ArabicNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'^[٠-٩]+$'), '');

    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}

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

  static void showAddressFormBottomSheet(
      {required BuildContext context,
      required LatLng latLng,
      Address? address}) {
    showAppBottomSheet(
        context: context,
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => getIt<AddUpdateAddressCubit>()),
          BlocProvider.value(value: context.read<GetAddressesCubit>())
        ], child: AddressFormWidget(latLng: latLng, address: address)));
  }
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
