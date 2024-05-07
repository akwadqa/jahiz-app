import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_item.dart';
import '../../../../core/widgets/app_error_widget.dart';
import 'location_map_bottom_sheet.dart';
import '../bloc/get_addresses/get_addresses_cubit.dart';
import '../../../../generated/l10n.dart';

class AddressesList extends StatelessWidget {
  const AddressesList({super.key, this.selecteable = true});

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
            const SizedBox(height: 13),
            const _AddAddressButton(),
            const SizedBox(height: 10),
          ],
        );
      }
      if (state is GetAddressesEmpty) {
        return const Center(
          child: _AddAddressButton(),
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
  const _AddAddressButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      child: TextButton(
          onPressed: () => showLocationMapBottomSheet(context),
          child: Text(
            S.of(context).addNewAddress,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          )),
    );
  }
}
