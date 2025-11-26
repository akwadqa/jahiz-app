import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/application/auth_cubit.dart';
import '../../../domain/entities/detailed_product.dart';
import '../../bloc/add_detailed_product_to_cart/add_detailed_product_to_cart_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/sign_up_login_bottom_sheet.dart';
import '../../../domain/entities/price_modifier.dart';
import '../../bloc/price_modifier/price_modifier_cubit.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.detailedProduct});
  final DetailedProduct detailedProduct;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDetailedProductToCartCubit,
        AddDetailedProductToCartState>(
      builder: (context, state) {
        if (state is AddDetailedProductToCartLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Theme.of(context).primaryColor)),
            onPressed: () {
              if (context.read<AuthCubit>().state is Authenticated) {
                context.read<AddDetailedProductToCartCubit>().addToCart(
                    detailedProduct,
                    context.read<PriceModifierCubit>().state.quantity);
                // .then((value) => context.maybePop());
              } else {
                showSignUpLoginBottomSheet(context);
              }
            },
            child: BlocBuilder<PriceModifierCubit, PriceModifier>(
                builder: (context, state) {
              return Text(
                  '${S.of(context).addToCart} ${state.quantity * detailedProduct.discountedPrice + state.amount} ${S.of(context).jod}');
            }),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddDetailedProductToCartError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
