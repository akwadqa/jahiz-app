import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/addresses/presentation/bloc/get_addresses/get_addresses_cubit.dart';
import '../../features/addresses/presentation/widgets/location_map_widget.dart';
import 'app_bottom_sheet.dart';

Future<dynamic> showLocationMapBottomSheet(BuildContext context) {
  return showAppBottomSheet(
      context: context,
      enableDrag: false,
      child: BlocProvider.value(
        value: context.read<GetAddressesCubit>(),
        child: const LocationMapWidget(),
      ));
}
