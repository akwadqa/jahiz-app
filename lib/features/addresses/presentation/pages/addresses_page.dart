import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../bloc/add_update_address/add_update_address_cubit.dart';
import '../bloc/get_addresses/get_addresses_cubit.dart';
import '../widgets/addresses_list.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

@RoutePage()
class AddressesPage extends StatelessWidget implements AutoRouteWrapper {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const CustomBackButton(),
            title: Text(S.of(context).myAddresses)),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: AddressesList(selecteable: false),
        ));
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => getIt<GetAddressesCubit>()..getAddresses()),
      BlocProvider(create: (context) => getIt<AddUpdateAddressCubit>()),
    ], child: this);
  }
}
