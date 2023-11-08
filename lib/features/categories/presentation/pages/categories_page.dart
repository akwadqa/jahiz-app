import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../domain/entities/category.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/no_elements_widget.dart';
import '../../../../injection_container.dart';

import '../bloc/categories/categories_cubit.dart';

@RoutePage()
class CategoriesPage extends StatelessWidget implements AutoRouteWrapper {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppHeader(title: S.of(context).shopByCategory),
        Positioned.fill(
          top: 130,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                color: Colors.white),
            padding: const EdgeInsets.only(top: 20.0),
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
              if (state is CategoriesLoadSuccess) {
                return RefreshIndicator.adaptive(
                  onRefresh: context.read<CategoriesCubit>().getCategories,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(
                        bottom: 100.0, top: 8.0, right: 20.0, left: 20.0),
                    itemCount: state.category.subCategories!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 3 / 4),
                    itemBuilder: (BuildContext context, int index) {
                      return _CategoryItem(
                          category: state.category.subCategories![index]);
                    },
                  ),
                );
              }
              if (state is CategoriesLoadFailure) {
                return AppErrorWidget(
                    errorText: state.error,
                    onRetryClicked:
                        context.read<CategoriesCubit>().getCategories);
              }
              if (state is CategoriesLoadEmpty) {
                return const NoElementsWidget();
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            }),
          ),
        )
      ],
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoriesCubit>(),
      child: this,
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        onTap: () => context
                .pushRoute(SubCategoriesRoute(categoryId: category.itemGroupId))
                .then((value) {
              if (value == true) {
                context.tabsRouter.setActiveIndex(2);
              }
            }),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                  width: double.maxFinite,
                  child: AppCachedNetworkImage(
                      imageUrl: category.image!, fit: BoxFit.fitWidth)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                category.websiteTitle!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
