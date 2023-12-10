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

  late String? _description;
  late List<ProductSpecification> _specifications;
  late List<ProductOption> _productOptions;

  bool _hasWebLongDescription = false;
  bool _hasProductOptions = false;
  bool _hasProductSpecifications = false;

  @override
  void initState() {
    _description = widget.detailedProduct.webLongDescription;
    _specifications = widget.detailedProduct.productSpecifications;
    _productOptions = widget.detailedProduct.productOptions;
    _hasWebLongDescription = _description?.isNotEmpty ?? false;
    _hasProductOptions = _productOptions.isNotEmpty;
    _hasProductSpecifications = _specifications.isNotEmpty;
    final tabBarLength = (_hasWebLongDescription ? 1 : 0) +
        (_hasProductSpecifications ? 1 : 0) +
        (_hasProductOptions ? 1 : 0);
    _tabController = TabController(length: tabBarLength, vsync: this);
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
              if (_hasProductOptions)
                Tab(
                    child: Text(S.of(context).options,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              if (_hasWebLongDescription)
                Tab(
                    child: Text(S.of(context).description,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              if (_hasProductSpecifications)
                Tab(
                    child: Text(S.of(context).specifications,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))
            ],
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            if (_hasProductOptions)
              _OptionsTabView(
                  productOptions: widget.detailedProduct.productOptions),
            if (_hasWebLongDescription)
              _DescriptionTabView(
                  description: widget.detailedProduct.webLongDescription ?? ''),
            if (_hasProductSpecifications)
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
                      labelText: productOptions[index].hint,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Metus aliquam eleifend mi in. Sit amet consectetur adipiscing elit pellentesque. Vel facilisis volutpat est velit egestas dui id ornare arcu. Quis commodo odio aenean sed adipiscing. Mauris in aliquam sem fringilla ut morbi. Tellus elementum sagittis vitae et leo duis ut diam. Nisi scelerisque eu ultrices vitae auctor eu augue. Nisl purus in mollis nunc sed id. Vivamus arcu felis bibendum ut tristique. Placerat orci nulla pellentesque dignissim enim sit. Mattis enim ut tellus elementum sagittis vitae et. Lobortis mattis aliquam faucibus purus. Tortor dignissim convallis aenean et tortor. Sed elementum tempus egestas sed sed risus pretium quam vulputate. Pellentesque dignissim enim sit amet venenatis urna cursus.
              
              Nibh tellus molestie nunc non blandit massa enim nec. Phasellus faucibus scelerisque eleifend donec. Tincidunt id aliquet risus feugiat in ante metus. Fringilla urna porttitor rhoncus dolor purus non enim. Faucibus nisl tincidunt eget nullam. Cum sociis natoque penatibus et magnis. Ultrices in iaculis nunc sed augue lacus viverra. Arcu cursus vitae congue mauris rhoncus aenean vel. Euismod quis viverra nibh cras pulvinar. Quam id leo in vitae turpis. Facilisis gravida neque convallis a cras semper auctor. Porttitor eget dolor morbi non arcu risus quis varius. Donec enim diam vulputate ut pharetra sit amet aliquam.
              
              Phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec. Fames ac turpis egestas integer eget aliquet nibh praesent. Odio pellentesque diam volutpat commodo. A iaculis at erat pellentesque adipiscing commodo elit. Et malesuada fames ac turpis egestas integer eget. Turpis tincidunt id aliquet risus feugiat in ante metus dictum. Nulla facilisi nullam vehicula ipsum a arcu cursus. Porta nibh venenatis cras sed felis eget velit. Quis commodo odio aenean sed. Viverra nam libero justo laoreet sit amet. Feugiat sed lectus vestibulum mattis ullamcorper velit sed. Tempor orci dapibus ultrices in iaculis nunc sed augue lacus. Cursus metus aliquam eleifend mi in nulla posuere sollicitudin aliquam. Aliquam etiam erat velit scelerisque in dictum non. Elementum facilisis leo vel fringilla est ullamcorper.
              
              Nulla facilisi morbi tempus iaculis urna id volutpat lacus. Porttitor leo a diam sollicitudin tempor id eu. Lectus vestibulum mattis ullamcorper velit sed. Interdum velit euismod in pellentesque massa placerat duis ultricies. Integer quis auctor elit sed vulputate mi sit amet. Dignissim enim sit amet venenatis urna. Feugiat sed lectus vestibulum mattis ullamcorper velit. Sed turpis tincidunt id aliquet risus feugiat. Nibh ipsum consequat nisl vel pretium lectus quam. Sem nulla pharetra diam sit amet nisl.
              
              Vestibulum morbi blandit cursus risus. Ut pharetra sit amet aliquam id. Sagittis purus sit amet volutpat consequat. Sed viverra tellus in hac. Suspendisse ultrices gravida dictum fusce. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus et. Tincidunt lobortis feugiat vivamus at augue. Sit amet cursus sit amet. Viverra ipsum nunc aliquet bibendum enim facilisis gravida. Eget mauris pharetra et ultrices neque. Fames ac turpis egestas integer eget. Egestas maecenas pharetra convallis posuere morbi leo. Lectus arcu bibendum at varius vel pharetra. Sed enim ut sem viverra aliquet eget sit amet. Viverra nibh cras pulvinar mattis nunc. Id semper risus in hendrerit gravida rutrum quisque. Morbi enim nunc faucibus a pellentesque sit. Non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Suscipit tellus mauris a diam maecenas. Morbi tristique senectus et netus et malesuada.
              
              Quisque sagittis purus sit amet volutpat consequat mauris nunc congue. Elementum integer enim neque volutpat ac tincidunt vitae semper quis. Leo vel fringilla est ullamcorper eget. A lacus vestibulum sed arcu non odio. Magna eget est lorem ipsum dolor. Vitae elementum curabitur vitae nunc sed. Ut porttitor leo a diam sollicitudin tempor. Sed sed risus pretium quam. Ullamcorper morbi tincidunt ornare massa eget egestas purus. Mi bibendum neque egestas congue. Pulvinar pellentesque habitant morbi tristique senectus et. Maecenas ultricies mi eget mauris pharetra et ultrices neque. Amet purus gravida quis blandit turpis cursus in hac habitasse. Augue lacus viverra vitae congue eu consequat ac. Sem nulla pharetra diam sit amet nisl suscipit adipiscing. Amet facilisis magna etiam tempor orci eu lobortis. Sed turpis tincidunt id aliquet risus. Magna sit amet purus gravida quis blandit turpis cursus in. Mi in nulla posuere sollicitudin aliquam ultrices sagittis.
              
              Viverra vitae congue eu consequat ac. Purus semper eget duis at. Integer quis auctor elit sed vulputate mi sit amet mauris. Lectus urna duis convallis convallis tellus id. Mi sit amet mauris commodo quis imperdiet massa tincidunt. Condimentum lacinia quis vel eros donec ac. Erat pellentesque adipiscing commodo elit. Pellentesque eu tincidunt tortor aliquam. Eget arcu dictum varius duis. Ipsum faucibus vitae aliquet nec ullamcorper sit amet. Aenean pharetra magna ac placerat vestibulum lectus mauris. Blandit libero volutpat sed cras ornare arcu. Cras semper auctor neque vitae tempus quam pellentesque. Sit amet purus gravida quis blandit turpis cursus in. A scelerisque purus semper eget. Lorem ipsum dolor sit amet consectetur adipiscing. Est ullamcorper eget nulla facilisi etiam dignissim diam quis enim. Molestie at elementum eu facilisis sed odio morbi quis commodo. Magna fringilla urna porttitor rhoncus dolor purus non enim.
              
              Interdum varius sit amet mattis vulputate enim nulla aliquet. Lectus proin nibh nisl condimentum id venenatis a condimentum. Condimentum vitae sapien pellentesque habitant morbi tristique. Morbi blandit cursus risus at ultrices mi tempus imperdiet nulla. Iaculis at erat pellentesque adipiscing commodo elit at imperdiet. Orci ac auctor augue mauris augue neque gravida in. Nunc scelerisque viverra mauris in aliquam. Suspendisse sed nisi lacus sed viverra tellus in. Feugiat nisl pretium fusce id velit ut tortor. Adipiscing tristique risus nec feugiat in fermentum posuere. Euismod quis viverra nibh cras pulvinar mattis nunc. Erat velit scelerisque in dictum non consectetur a. Enim neque volutpat ac tincidunt vitae semper quis lectus nulla. Massa placerat duis ultricies lacus. Arcu ac tortor dignissim convallis. Risus nullam eget felis eget nunc lobortis. Bibendum est ultricies integer quis auctor. Odio morbi quis commodo odio aenean sed adipiscing diam.
              
              Proin nibh nisl condimentum id venenatis a condimentum. Aliquam vestibulum morbi blandit cursus risus at ultrices mi tempus. Blandit massa enim nec dui nunc mattis enim ut. Sed augue lacus viverra vitae congue eu. Viverra accumsan in nisl nisi scelerisque eu. Enim tortor at auctor urna nunc id cursus. Dictum varius duis at consectetur lorem. Sed ullamcorper morbi tincidunt ornare massa. Convallis aenean et tortor at risus. Vitae sapien pellentesque habitant morbi tristique. A diam sollicitudin tempor id eu nisl. Fermentum odio eu feugiat pretium nibh ipsum. Etiam non quam lacus suspendisse faucibus interdum posuere. Aliquam faucibus purus in massa tempor. Massa eget egestas purus viverra accumsan in nisl nisi scelerisque. Ut porttitor leo a diam sollicitudin tempor id. Odio euismod lacinia at quis. Sociis natoque penatibus et magnis dis parturient. Elementum curabitur vitae nunc sed velit dignissim sodales ut. Tellus cras adipiscing enim eu turpis egestas.
              
              Tincidunt eget nullam non nisi. Mauris sit amet massa vitae tortor condimentum lacinia quis vel. Diam donec adipiscing tristique risus nec feugiat in fermentum posuere. Amet aliquam id diam maecenas ultricies mi eget mauris pharetra. Ut pharetra sit amet aliquam id diam. Commodo viverra maecenas accumsan lacus vel facilisis volutpat est velit. Dolor morbi non arcu risus quis varius quam. Facilisis magna etiam tempor orci eu lobortis elementum nibh. Faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis. Tellus cras adipiscing enim eu turpis. Nisl condimentum id venenatis a condimentum. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget gravida. Aliquam ut porttitor leo a diam sollicitudin tempor id eu. Dui ut ornare lectus sit amet est placerat.''',
          style: TextStyle(fontSize: 18)),
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
