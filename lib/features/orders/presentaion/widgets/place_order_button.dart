import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/generated/l10n.dart';

import '../bloc/place_order/place_order_cubit.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
        builder: (context, state) {
      if (state is PlaceOrderLoading) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if (state is PlaceOrderError) {
        return AppErrorWidget(
            errorText: state.message, onRetryClicked: onPressed);
      }
      return ElevatedButton(
          onPressed: onPressed, child: Text(S.of(context).confirm));
    });
  }
}
