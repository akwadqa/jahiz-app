import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/generated/l10n.dart';

import '../bloc/create_order/create_order_cubit.dart';

class CreateOrderButton extends StatelessWidget {
  const CreateOrderButton({Key? key, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      if (state is CreateOrderLoading) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if (state is CreateOrderError) {
        return AppErrorWidget(
            errorText: state.message, onRetryClicked: onPressed);
      }
      return ElevatedButton(
          onPressed: onPressed, child: Text(S.of(context).confirm));
    });
  }
}
