import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/shared_functions.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget({super.key});

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
          context.maybePop().then((value) {
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
    _goToCurrentLocation();
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
            zoom: 18.0,
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

  void _goToCurrentLocation() async {
    final LatLng? myLocation = await _getMyLocation();
    if (myLocation != null) {
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          myLocation,
          18,
        ),
      );
      _currentPosition = myLocation;
    }
  }

  Future<LatLng?> _getMyLocation() async {
    final location = await _determinePosition();
    return LatLng(location.latitude, location.longitude);
  }

  Future<Position> _determinePosition() async {
    await _requestLocationPermission();
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
