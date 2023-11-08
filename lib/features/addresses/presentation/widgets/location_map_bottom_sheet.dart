import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/get_addresses/get_addresses_cubit.dart';
import 'location_map_widget.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';

Future<dynamic> showLocationMapBottomSheet(BuildContext context) {
  return showAppBottomSheet(
      context: context,
      enableDrag: false,
      child: BlocProvider.value(
        value: context.read<GetAddressesCubit>(),
        child: const LocationMapWidget(),
      ));
}
