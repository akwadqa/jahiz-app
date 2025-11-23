import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/gen/assets.gen.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/core/widgets/custom_back_button.dart';
import 'package:jahiz/core/widgets/no_elements_widget.dart';
import 'package:jahiz/features/cart/application/cart_count_cubit.dart';
import 'package:jahiz/features/categories/presentation/bloc/sub_categories/sub_categories_cubit.dart';
import 'package:jahiz/features/home/presentation/widgets/dynamic_layout.dart';
import 'package:jahiz/features/products/presentation/widgets/product_item.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart' as di;

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).allProducts),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _SearchTextFormField(),
        ],
      ),
    );
  }
}

class _SearchTextFormField extends StatelessWidget {
  const _SearchTextFormField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.darkGreen)),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              // const Spacer(),
              Expanded(
                flex: 3,
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      hint: Text(
                        S.of(context).searchHint,
                        style: const TextStyle(fontSize: 16),
                      ),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
                // child: Text(
                //   S.of(context).searchHint,
                //   style: const TextStyle(fontSize: 16),
                // )
              ),
              IconButton(onPressed: null, icon: Assets.images.search.svg()),
            ],
          ),
        ),
      ),
    );
  }
}

//? Use This code to make the grid view
/*
BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                      buildWhen: (previous, current) =>
                          (previous as SubCategoriesLoadSuccess)
                              .productsState !=
                          (current as SubCategoriesLoadSuccess).productsState,
                      builder: (context, state) {
                        return Expanded(
                          child: (state as SubCategoriesLoadSuccess)
                                  .productsState is ProductsLoadSuccess
                              ? GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 12,
                                          crossAxisSpacing: 12,
                                          childAspectRatio: 2 / 3),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductItem(
                                        product: (state.productsState
                                                as ProductsLoadSuccess)
                                            .products[index],
                                        viewType: ViewType.grid,
                                        index: index);
                                  },
                                  itemCount: (state.productsState
                                          as ProductsLoadSuccess)
                                      .products
                                      .length,
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 20.0,
                                      bottom: 120),
                                )
                              : state.productsState is ProductsLoadEmpty
                                  ? const Center(child: NoElementsWidget())
                                  : state.productsState is ProductsLoadFailure
                                      ? AppErrorWidget(
                                          errorText: (state.productsState
                                                  as ProductsLoadFailure)
                                              .error,
                                          onRetryClicked: () => context
                                              .read<SubCategoriesCubit>()
                                              .loadProductsOfCategory(state
                                                  .selectedCategory!
                                                  .itemGroupId))
                                      : const Center(
                                          child: CircularProgressIndicator
                                              .adaptive()),
                        );
                      })
*/
