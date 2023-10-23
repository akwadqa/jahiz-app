import 'package:flutter/material.dart';
import '../../features/addresses/presentation/widgets/location_map_widget.dart';
import 'app_bottom_sheet.dart';

Future<dynamic> showLocationMapBottomSheet(BuildContext context) {
  return showAppBottomSheet(
      context: context, enableDrag: false, child: const LocationMapWidget());
}
