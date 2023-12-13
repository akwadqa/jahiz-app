import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/core/widgets/change_quantity_button.dart';
import 'package:jahiz/core/widgets/custom_through_line.dart';
import 'package:jahiz/features/products/domain/entities/detailed_product.dart';
import 'package:jahiz/features/products/domain/entities/price_modifier.dart';
import 'package:jahiz/features/products/presentation/bloc/price_modifier/price_modifier_cubit.dart';
import 'package:jahiz/generated/l10n.dart';

class ProductDetailsData extends StatelessWidget {
  const ProductDetailsData({super.key, required this.detailedProduct});

  final DetailedProduct detailedProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detailedProduct.websiteItemName, style: _titleTextStyle()),
                Text('- ${detailedProduct.stockUom}',
                    style: const TextStyle(color: AppColors.midnight)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                        '${detailedProduct.discountedPrice} ${S.of(context).qar}',
                        style: _titleTextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    if (detailedProduct.discountAmount > 0)
                      CustomThroughLine(
                          productPrice:
                              '${detailedProduct.itemPrice} ${S.of(context).qar}',
                          isSmallestPremiumItem: false),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (detailedProduct.productOptions
                .indexWhere((element) => element.isPriceModifier == 1) ==
            -1) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeQuantityButton(
                  onPressed:
                      context.read<PriceModifierCubit>().decrementQuantity,
                  icon: Icons.remove),
              const SizedBox(width: 20),
              BlocBuilder<PriceModifierCubit, PriceModifier>(
                  builder: (context, state) {
                return Text(state.quantity.toString(),
                    style:
                        _titleTextStyle(color: Theme.of(context).primaryColor));
              }),
              const SizedBox(width: 20),
              ChangeQuantityButton(
                  onPressed:
                      context.read<PriceModifierCubit>().incrementQuantity,
                  icon: Icons.add),
            ],
          ),
          const SizedBox(height: 35),
        ]
      ],
    );
  }

  TextStyle _titleTextStyle(
          {double fontSize = 23, Color color = AppColors.midnight}) =>
      TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold);
}
