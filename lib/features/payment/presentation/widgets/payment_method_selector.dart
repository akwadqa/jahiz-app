import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../domain/entities/payment_method.dart';
import '../bloc/payment_methods_cubit.dart';

class PaymentMethodsSelector extends FormField<PaymentMethod> {
  PaymentMethodsSelector(
      {Key? key,
      required BuildContext context,
      void Function(PaymentMethod?)? onSaved,
      required Function(PaymentMethod) onSelected})
      : super(
            onSaved: onSaved,
            validator: (value) => value == null ? S.of(context).required : null,
            builder: (state) =>
                _builder(context, state, onSelected: onSelected),
            key: key);

  static Widget _builder(
      BuildContext context, FormFieldState<PaymentMethod> formFieldState,
      {required Function(PaymentMethod) onSelected}) {
    return Column(
      children: [
        BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
            builder: (context, state) {
          if (state is PaymentMethodsLoaded) {
            return SizedBox(
              height: 60.0,
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _PaymentMethodItem(
                      paymentMethod: state.paymentMethods[index],
                      formFieldState: formFieldState,
                      onSelected: onSelected);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 18.0),
                scrollDirection: Axis.horizontal,
                itemCount: state.paymentMethods.length,
              ),
            );
          }
          if (state is PaymentMethodsError) {
            return AppErrorWidget(
                errorText: state.message,
                onRetryClicked:
                    context.read<PaymentMethodsCubit>().getPaymentMethods);
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }),
        if (formFieldState.hasError) ...[
          const SizedBox(height: 4.0),
          Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(formFieldState.errorText!,
                  style: const TextStyle(color: AppColors.red))),
        ]
      ],
    );
  }
}

class _PaymentMethodItem extends StatelessWidget {
  const _PaymentMethodItem(
      {Key? key,
      required this.paymentMethod,
      required this.formFieldState,
      required this.onSelected})
      : super(key: key);
  final PaymentMethod paymentMethod;
  final FormFieldState<PaymentMethod> formFieldState;
  final Function(PaymentMethod) onSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 2.5, end: 2.5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5.0),
              border: formFieldState.value != null &&
                      formFieldState.value == paymentMethod
                  ? Border.all(color: Theme.of(context).primaryColor)
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                onTap: () {
                  if (formFieldState.value != paymentMethod ||
                      formFieldState.value?.isEmbedded == 1) {
                    formFieldState.didChange(paymentMethod);
                    onSelected(paymentMethod);
                  }
                },
                borderRadius: BorderRadius.circular(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(children: [
                    CachedNetworkImage(imageUrl: paymentMethod.icon),
                    const SizedBox(width: 8.0),
                    Text(paymentMethod.paymentMethodTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray)),
                  ]),
                ),
              ),
            ),
          ),
        ),
        if (formFieldState.value != null &&
            formFieldState.value == paymentMethod)
          PositionedDirectional(
            top: 0.0,
            end: 0.0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 10.0,
              child: const Icon(Icons.check, color: Colors.white, size: 12.0),
            ),
          )
      ],
    );
  }
}
