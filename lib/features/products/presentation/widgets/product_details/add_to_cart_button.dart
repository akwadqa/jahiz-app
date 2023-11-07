import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/features/products/domain/entities/detailed_product.dart';
import 'package:jahiz/features/products/presentation/bloc/add_detailed_product_to_cart/add_detailed_product_to_cart_cubit.dart';
import 'package:jahiz/generated/l10n.dart';
import '../../../../../core/widgets/sign_up_login_bottom_sheet.dart';
import '../../../domain/entities/price_modifier.dart';
import '../../bloc/price_modifier/price_modifier_cubit.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key? key, required this.detailedProduct})
      : super(key: key);
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
            onPressed: () {
              if (context.read<AuthCubit>().state is Authenticated) {
                context
                    .read<AddDetailedProductToCartCubit>()
                    .addToCart(detailedProduct,
                        context.read<PriceModifierCubit>().state.quantity)
                    .then((value) => context.popRoute());
              } else {
                showSignUpLoginBottomSheet(context);
              }
            },
            child: BlocBuilder<PriceModifierCubit, PriceModifier>(
                builder: (context, state) {
              return Text(
                  '${S.of(context).addToCart} ${state.quantity * detailedProduct.discountedPrice + state.amount} ${S.of(context).qar}');
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
