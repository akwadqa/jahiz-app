import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jahiz/features/addresses/presentation/bloc/add_update_address/add_update_address_cubit.dart';
import 'package:jahiz/features/addresses/presentation/widgets/address_form_widget.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late LatLng latLng;
    return AppBottomSheetSkeleton(
      title: S.of(context).chooseYourLocation,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: _MapWidget(onLocationSelected: (LatLng value) => latLng = value),
      ),
      scrollPhysics: const NeverScrollableScrollPhysics(),
      submitButton: ElevatedButton(
        onPressed: () {
          context.popRoute().then((value) {
            showAppBottomSheet(
                context: context,
                child: BlocProvider(
                    create: (_) => getIt<AddUpdateAddressCubit>(),
                    child: AddressFormWidget(latLng: latLng)));
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

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(25.286106, 51.534817),
    zoom: 14.4746,
  );

  @override
  void initState() {
    widget.onLocationSelected(_kGooglePlex.target);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onCameraMove: (CameraPosition position) {
        setState(() {
          _kGooglePlex = position;
        });
        widget.onLocationSelected(position.target);
      },
      myLocationEnabled: true,
      markers: {
        Marker(
          markerId: const MarkerId('marker_1'),
          position: _kGooglePlex.target,
        ),
      },
    );
  }
}
