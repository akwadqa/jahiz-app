import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jahiz/features/cities/presentation/blocs/get_cities_cubit.dart';
import 'package:jahiz/injection_container.dart';
import '../../../../core/shared_functions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/address.dart';
import '../../../cities/domain/entities/city.dart';
import '../bloc/add_update_address/add_update_address_cubit.dart';
import '../bloc/get_addresses/get_addresses_cubit.dart';
import 'cities_list.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';

import 'address_type_selector.dart';

class AddressFormWidget extends StatelessWidget {
  const AddressFormWidget({Key? key, required this.latLng, this.address})
      : super(key: key);
  final LatLng latLng;
  final Address? address;
  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
      title: S.of(context).enterYourLocation,
      content: Form(
        key: context.read<AddUpdateAddressCubit>().formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            AddressTypeSelector(
                initialValue: AddressType.values.firstWhere(
                    (element) => element.name == address?.addressTitle,
                    orElse: () => AddressType.home),
                onSelected: context
                    .read<AddUpdateAddressCubit>()
                    .onAddressTypeSelected),
            const SizedBox(height: 30.0),
            Text(S.of(context).addressDetails, style: _titleStyle),
            const SizedBox(height: 10.0),
            TextFormField(
              initialValue: address?.akdZoneNumber.toString(),
              decoration: InputDecoration(
                label: Text(S.of(context).zoneNumber),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ArabicNumberInputFormatter(),
                LengthLimitingTextInputFormatter(2)
              ],
              validator: context
                  .read<AddUpdateAddressCubit>()
                  .zoneNumberValidator(context),
              onSaved: (value) => context
                  .read<AddUpdateAddressCubit>()
                  .onZoneNumberSaved(value),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              initialValue: address?.buildingNo,
              decoration: InputDecoration(
                label: Text(S.of(context).buildingNameOrNumber),
              ),
              validator:
                  context.read<AddUpdateAddressCubit>().validator(context),
              onSaved: context
                  .read<AddUpdateAddressCubit>()
                  .onBuildingNameOrNumberSaved,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              initialValue: address?.streetNo,
              decoration: InputDecoration(
                label: Text(S.of(context).streetNameOrNumber),
              ),
              validator:
                  context.read<AddUpdateAddressCubit>().validator(context),
              onSaved: context
                  .read<AddUpdateAddressCubit>()
                  .onStreetNameOrNumberSaved,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 10.0),
            _CityTextFormField(initialCity: address?.city),
            Row(
              children: [
                _ShippingCheckBox(
                    isDefaultShippingAddress: address?.isShippingAddress == 1),
                Text(S.of(context).defaultShippingAddress)
              ],
            ),
            const SizedBox(height: 30),
            Text(S.of(context).receiverDetails, style: _titleStyle),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: address?.phone,
              decoration: InputDecoration(
                label: Text(S.of(context).receiverPhoneNumber),
              ),
              validator: context
                  .read<AddUpdateAddressCubit>()
                  .phoneNumberValidator(context),
              onSaved: context
                  .read<AddUpdateAddressCubit>()
                  .onReceiverPhoneNumberSaved,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 350),
          ],
        ),
      ),
      stackedSubmitButton:
          BlocConsumer<AddUpdateAddressCubit, AddUpdateAddressState>(
              listener: (context, state) {
        if (state is AddUpdateAddressError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is AddUpdateAddressLoaded) {
          context.read<GetAddressesCubit>().getAddresses();
          context.popRoute();
        }
      }, builder: (context, state) {
        if (state is AddUpdateAddressLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return ElevatedButton(
            onPressed: () => context
                .read<AddUpdateAddressCubit>()
                .submit(latLng, address?.addressId),
            child: Text(S.of(context).continueLabel));
      }),
    );
  }

  TextStyle get _titleStyle => const TextStyle(
      color: AppColors.gray, fontSize: 18.0, fontWeight: FontWeight.w500);
}

class _ShippingCheckBox extends StatefulWidget {
  const _ShippingCheckBox({Key? key, this.isDefaultShippingAddress = false})
      : super(key: key);
  final bool isDefaultShippingAddress;

  @override
  State<_ShippingCheckBox> createState() => _ShippingCheckBoxState();
}

class _ShippingCheckBoxState extends State<_ShippingCheckBox> {
  late bool _isDefaultShippingAddress;

  @override
  void initState() {
    _isDefaultShippingAddress = widget.isDefaultShippingAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isDefaultShippingAddress,
      onChanged: (bool? value) {
        if (value != null) {
          setState(() {
            _isDefaultShippingAddress = value;
          });
          context.read<AddUpdateAddressCubit>().onIsDefaultAddressSaved(value);
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
    );
  }
}

class _CityTextFormField extends StatefulWidget {
  const _CityTextFormField({Key? key, required this.initialCity})
      : super(key: key);
  final City? initialCity;
  @override
  State<_CityTextFormField> createState() => _CityTextFormFieldState();
}

class _CityTextFormFieldState extends State<_CityTextFormField> {
  City? _selectedCity;
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.initialCity?.cityName ?? '';
    _selectedCity = widget.initialCity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        label: Text(S.of(context).city),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      readOnly: true,
      validator: context.read<AddUpdateAddressCubit>().validator(context),
      onSaved: (_) =>
          context.read<AddUpdateAddressCubit>().onCitySaved(_selectedCity),
      onTap: () async {
        final City? city = await showAppBottomSheet(
            context: context,
            child: BlocProvider(
              create: (_) => getIt<GetCitiesCubit>(),
              child: const CitiesList(),
            ));
        if (city != null) {
          _selectedCity = city;
          _controller.text = city.cityName;
        }
      },
    );
  }
}
