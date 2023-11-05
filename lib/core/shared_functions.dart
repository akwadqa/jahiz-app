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
import 'package:queen_validators/queen_validators.dart';

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
