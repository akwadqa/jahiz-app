import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/get_addresses/get_addresses_cubit.dart';
import 'addresses_list.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

import '../../../../core/widgets/app_bottom_sheet.dart';

Future<dynamic> showLocationSelectorBottomSheet(BuildContext context) {
  return showAppBottomSheet(
    context: context,
    child: BlocProvider(
      create: (context) => getIt<GetAddressesCubit>()..getAddresses(),
      child: const LocationSelectorWidget(),
    ),
  );
}

class LocationSelectorWidget extends StatelessWidget {
  const LocationSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
      title: S.of(context).chooseYourLocation,
      content: const Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: AddressesList(),
      ),
      isShowBackButton: false,
    );
  }
}
