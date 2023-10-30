import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/addresses/presentation/widgets/address_item.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/core/widgets/location_map_bottom_sheet.dart';
import 'package:jahiz/core/widgets/no_elements_widget.dart';
import 'package:jahiz/features/addresses/presentation/bloc/get_addresses/get_addresses_cubit.dart';
import 'package:jahiz/generated/l10n.dart';

class AddressesList extends StatelessWidget {
  const AddressesList({Key? key, this.selecteable = true}) : super(key: key);

  final bool selecteable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAddressesCubit, GetAddressesState>(
        builder: (context, state) {
      if (state is GetAddressesLoaded) {
        return Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                  children: state.addresses
                      .map((address) => Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: selecteable
                              ? InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pop(address),
                                  radius: 5.0,
                                  child: AddressItem(address: address))
                              : AddressItem(
                                  address: address, isEditiable: true)))
                      .toList()),
            )),
            const SizedBox(height: 20),
            const _AddAddressButton(),
          ],
        );
      }
      if (state is GetAddressesEmpty) {
        return const Column(
          children: [
            Expanded(child: NoElementsWidget()),
            SizedBox(height: 20),
            _AddAddressButton(),
          ],
        );
      }
      if (state is GetAddressesError) {
        return AppErrorWidget(
            errorText: state.message,
            onRetryClicked: context.read<GetAddressesCubit>().getAddresses);
      }
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

class _AddAddressButton extends StatelessWidget {
  const _AddAddressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => showLocationMapBottomSheet(context),
        child: Text(S.of(context).addNewAddress));
  }
}
