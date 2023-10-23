import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/features/products/domain/entities/price_modifier.dart';
import 'package:jahiz/generated/l10n.dart';

import '../../../../../core/widgets/change_quantity_button.dart';
import '../../../domain/entities/detailed_product.dart';
import '../../bloc/price_modifier/price_modifier_cubit.dart';

class ProductDetailsSliverList extends StatelessWidget {
  const ProductDetailsSliverList({Key? key, required this.detailedProduct})
      : super(key: key);
  final DetailedProduct detailedProduct;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(detailedProduct.websiteItemName, style: _titleTextStyle()),
            const SizedBox(height: 10),
            const Text('-500g', style: TextStyle(color: AppColors.midnight)),
            Row(
              children: [
                Text('${detailedProduct.discountedPrice} ${S.of(context).qar}',
                    style: _titleTextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Text('${detailedProduct.itemPrice} ${S.of(context).qar}',
                    style: const TextStyle(
                        color: AppColors.midnight,
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough)),
              ],
            ),
          ],
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
                onPressed: context.read<PriceModifierCubit>().decrementQuantity,
                icon: Icons.remove),
            const SizedBox(width: 10),
            BlocBuilder<PriceModifierCubit, PriceModifier>(
                builder: (context, state) {
              return Text(state.quantity.toString(),
                  style:
                      _titleTextStyle(color: Theme.of(context).primaryColor));
            }),
            const SizedBox(width: 10),
            ChangeQuantityButton(
                onPressed: context.read<PriceModifierCubit>().incrementQuantity,
                icon: Icons.add),
          ],
        ),
        const SizedBox(height: 35),
      ],
    ]));
  }

  TextStyle _titleTextStyle(
          {double fontSize = 25, Color color = AppColors.midnight}) =>
      TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold);
}
