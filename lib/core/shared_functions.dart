import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jahiz/core/router/app_router.dart';
import 'app_constants.dart';
import 'widgets/app_bottom_sheet.dart';
import '../features/addresses/domain/entities/address.dart';
import '../features/addresses/presentation/bloc/add_update_address/add_update_address_cubit.dart';
import '../features/addresses/presentation/bloc/get_addresses/get_addresses_cubit.dart';
import '../features/addresses/presentation/widgets/address_form_widget.dart';
import '../generated/l10n.dart';
import '../injection_container.dart';
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

  static bool hasNotch(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return topPadding > 30.0;
  }

  static void openSubCategoriesRoute(BuildContext context, String categoryId) {
    context.pushRoute(SubCategoriesRoute(categoryId: categoryId)).then((value) {
      if (value == true) {
        context.tabsRouter.setActiveIndex(2);
      }
    });
  }
}
