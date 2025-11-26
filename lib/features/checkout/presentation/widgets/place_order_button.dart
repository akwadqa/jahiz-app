import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../bloc/place_order/place_order_cubit.dart';
import '../../../../generated/l10n.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({super.key, required this.onPressed});
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
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor)),
          child: Text(S.of(context).confirm));
    });
  }
}
