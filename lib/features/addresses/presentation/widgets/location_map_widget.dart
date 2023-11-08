import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/shared_functions.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late LatLng latLng;
    return AppBottomSheetSkeleton(
      title: S.of(context).chooseYourLocation,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: _MapWidget(onLocationSelected: (LatLng value) => latLng = value),
      ),
      scrollPhysics: const NeverScrollableScrollPhysics(),
      submitButton: ElevatedButton(
        onPressed: () {
          context.popRoute().then((value) {
            SharedFunctions.showAddressFormBottomSheet(
                context: context, latLng: latLng);
          });
        },
        child: Text(S.of(context).continueLabel),
      ),
    );
  }
}

class _MapWidget extends StatefulWidget {
  const _MapWidget({required this.onLocationSelected});
  final Function(LatLng latLng) onLocationSelected;
  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  late LatLng _currentPosition;

  @override
  void initState() {
    _currentPosition = const LatLng(25.286106, 51.534817);
    widget.onLocationSelected(_currentPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 14.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onCameraMove: (position) {
            _currentPosition = position.target;
            widget.onLocationSelected(_currentPosition);
          },
          myLocationEnabled: true,
        ),
        const Center(
          child: Icon(Icons.location_on, color: Colors.red, size: 40),
        )
      ],
    );
  }
}
