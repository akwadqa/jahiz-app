import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/detailed_product.dart';
import '../../../domain/entities/product_specification.dart';
import '../../../../../generated/l10n.dart';

import '../../../domain/entities/product_option.dart';
import '../../bloc/add_detailed_product_to_cart/add_detailed_product_to_cart_cubit.dart';
import '../../bloc/price_modifier/price_modifier_cubit.dart';
import 'items_selector_form_field.dart';

class ProductDetailsTabs extends StatefulWidget {
  const ProductDetailsTabs({Key? key, required this.detailedProduct})
      : super(key: key);

  final DetailedProduct detailedProduct;

  @override
  State<ProductDetailsTabs> createState() => _ProductDetailsTabsState();
}

class _ProductDetailsTabsState extends State<ProductDetailsTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddDetailedProductToCartCubit>().formKey,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: S.of(context).options),
              Tab(text: S.of(context).description),
              Tab(text: S.of(context).specifications)
            ],
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            _OptionsTabView(
                productOptions: widget.detailedProduct.productOptions),
            _DescriptionTabView(
                description: widget.detailedProduct.webLongDescription ?? ''),
            _SpecificationsTabView(
                productSpecifications:
                    widget.detailedProduct.productSpecifications)
          ]))
        ],
      ),
    );
  }
}

enum OptionType {
  radioGroup('Radio Group'),
  textInput('Text Input'),
  numberInput('Number Input'),
  textArea('Text Area');

  const OptionType(this.name);
  final String name;
}

class _OptionsTabView extends StatelessWidget {
  const _OptionsTabView({Key? key, required this.productOptions})
      : super(key: key);
  final List<ProductOption> productOptions;
  @override
  Widget build(BuildContext context) {
    const InputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.mediumLightGray),
    );
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        itemBuilder: (context, index) {
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productOptions[index].optionName,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                if (productOptions[index].optionType ==
                        OptionType.textInput.name ||
                    productOptions[index].optionType ==
                        OptionType.textArea.name ||
                    productOptions[index].optionType ==
                        OptionType.numberInput.name)
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: productOptions[index].hint,
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                    ),
                    maxLines: productOptions[index].optionType ==
                            OptionType.textArea.name
                        ? 3
                        : null,
                    keyboardType: productOptions[index].optionType ==
                            OptionType.numberInput.name
                        ? TextInputType.number
                        : null,
                    onChanged: productOptions[index].optionType ==
                                OptionType.numberInput.name &&
                            productOptions[index].isPriceModifier == 1
                        ? (value) {
                            if (value.isNotEmpty) {
                              context
                                  .read<PriceModifierCubit>()
                                  .setAmount(double.parse(value));
                            }
                          }
                        : null,
                    validator: productOptions[index].isMandatory == 1
                        ? context
                            .read<AddDetailedProductToCartCubit>()
                            .validator(context)
                        : null,
                    onSaved: (value) => context
                        .read<AddDetailedProductToCartCubit>()
                        .onSaved(productOptions[index], value!),
                  ),
                if (productOptions[index].optionType ==
                    OptionType.radioGroup.name)
                  ItemsSelectorFormField(
                    items: productOptions[index].radioGroupOption,
                    validator: (value) => productOptions[index].isMandatory == 1
                        ? context
                            .read<AddDetailedProductToCartCubit>()
                            .selectorValidator(value, context)
                        : null,
                    onSaved: (value) => value != null
                        ? context
                            .read<AddDetailedProductToCartCubit>()
                            .onSaved(productOptions[index], value)
                        : null,
                  )
              ],
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20.0),
        itemCount: productOptions.length);
  }
}

class _DescriptionTabView extends StatelessWidget {
  const _DescriptionTabView({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(description, style: const TextStyle(fontSize: 18)),
    );
  }
}

class _SpecificationsTabView extends StatelessWidget {
  const _SpecificationsTabView({Key? key, required this.productSpecifications})
      : super(key: key);
  final List<ProductSpecification> productSpecifications;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: productSpecifications
            .map((e) => DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    color: productSpecifications.indexOf(e).isEven
                        ? Colors.white
                        : Theme.of(context).primaryColor.withOpacity(0.2),
                    child: Row(children: [
                      Expanded(child: Text(e.label)),
                      Expanded(child: Text(e.description))
                    ]),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
