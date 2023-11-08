import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/gen/fonts.gen.dart';
import '../../../../core/shared_functions.dart';
import 'location_selector_widget.dart';
import '../../../cart/application/cart_service.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

import '../../domain/entities/address.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';

class AddressItem extends StatelessWidget {
  const AddressItem(
      {Key? key,
      required this.address,
      this.isChangeable = false,
      this.isEditiable = false})
      : super(key: key);
  final Address address;
  final bool isChangeable;
  final bool isEditiable;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: isChangeable || isEditiable
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AddressDetailsRow(address: address),
                isEditiable
                    ? IconButton(
                        onPressed: () =>
                            SharedFunctions.showAddressFormBottomSheet(
                                context: context,
                                latLng: LatLng(
                                    double.parse(address.akdAltitude),
                                    double.parse(address.akdLongitude)),
                                address: address),
                        icon: Assets.images.editIcon.svg())
                    : SizedBox(
                        width: 80.0,
                        height: 40.0,
                        child: ElevatedButton(
                            onPressed: () {
                              showLocationSelectorBottomSheet(context)
                                  .then((address) {
                                if (address != null) {
                                  getIt<CartService>()
                                      .updateCartAddress(address);
                                }
                              });
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0.0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateProperty.all(
                                  const BorderSide(color: AppColors.red)),
                              foregroundColor:
                                  MaterialStateProperty.all(AppColors.red),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)))),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Text(S.of(context).change,
                                style: const TextStyle(
                                    fontFamily: FontFamily.qatar))),
                      )
              ],
            )
          : _AddressDetailsRow(address: address),
    );
  }
}

class _AddressDetailsRow extends StatelessWidget {
  const _AddressDetailsRow({Key? key, required this.address}) : super(key: key);
  final Address address;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
          child: Assets.images.locationIcon.svg(),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address.addressTitle,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4.0),
            Text(
                '${address.city.cityName}, ${address.akdZoneNumber}, ${address.streetNo},\n${address.buildingNo}',
                style: const TextStyle(color: AppColors.darkGray)),
            Text('${S.of(context).phone} ${address.phone}'),
          ],
        ),
      ],
    );
  }
}
