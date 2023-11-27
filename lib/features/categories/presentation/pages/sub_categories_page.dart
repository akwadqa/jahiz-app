import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/home/presentation/widgets/dynamic_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/presentation/widgets/product_item.dart';
import '../../../cart/application/cart_count_cubit.dart';
import '../bloc/sub_categories/sub_categories_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/no_elements_widget.dart';
import '../../../../injection_container.dart';

@RoutePage()
class SubCategoriesPage extends StatelessWidget implements AutoRouteWrapper {
  const SubCategoriesPage({Key? key, required this.categoryId})
      : super(key: key);
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).allProducts),
      ),
      body: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
          buildWhen: (previous, current) =>
              !(previous is SubCategoriesLoadSuccess &&
                  current is SubCategoriesLoadSuccess),
          builder: (context, state) {
            if (state is SubCategoriesLoadSuccess) {
              if (state.category.subCategories!.isEmpty &&
                  state.category.products!.isEmpty) {
                return const NoElementsWidget();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                        buildWhen: (previous, current) =>
                            (previous as SubCategoriesLoadSuccess)
                                .selectedCategory !=
                            (current as SubCategoriesLoadSuccess)
                                .selectedCategory,
                        builder: (context, state) {
                          return Wrap(
                              spacing: 6,
                              children: (state as SubCategoriesLoadSuccess)
                                  .category
                                  .subCategories!
                                  .map((e) => ChoiceChip(
                                        showCheckmark: false,
                                        shadowColor: const Color(0xFF9C9C9C),
                                        label: Text(
                                            e.websiteTitle ?? 'smartphone'),
                                        elevation: 2,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8),
                                        backgroundColor:
                                            state.selectedCategory == e
                                                ? Theme.of(context).primaryColor
                                                : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18,
                                                color:
                                                    state.selectedCategory == e
                                                        ? Colors.white
                                                        : Colors.black),
                                        selected: state.selectedCategory == e,
                                        onSelected: (value) {
                                          if (value) {
                                            context
                                                .read<SubCategoriesCubit>()
                                                .loadProductsOfCategory(
                                                    e.itemGroupId);
                                          }
                                        },
                                      ))
                                  .toList());
                        }),
                  ),
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
                ],
              );
            }
            if (state is SubCategoriesLoadFailure) {
              return AppErrorWidget(
                  errorText: state.error,
                  onRetryClicked:
                      context.read<SubCategoriesCubit>().getSubCategories);
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          }),
      bottomNavigationBar: BlocBuilder<CartCountCubit, int>(
        builder: (context, state) {
          if (state == 0) {
            return const SizedBox.shrink();
          }
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppColors.green,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.16))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Assets.images.cartIcon.svg(color: Colors.white),
                    const SizedBox(width: 5),
                    Text(S.of(context).youHaveItemsInYourCart,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white, fontSize: 15))
                  ],
                ),
                TextButton(
                    onPressed: () => context.popRoute(true),
                    child: Text(S.of(context).viewCart,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white, fontSize: 15)))
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SubCategoriesCubit>(param1: categoryId),
      child: this,
    );
  }
}
