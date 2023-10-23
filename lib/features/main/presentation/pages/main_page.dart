import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/router/app_router.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';
import 'package:jahiz/features/products/presentation/bloc/home/home_cubit.dart';
import 'package:jahiz/features/main/presentation/widgets/custom_bottom_navigation_bar.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: AutoTabsScaffold(
        routes: const [
          HomeRoute(),
          CategoriesRoute(),
          CartRoute(),
          ProfileRoute()
        ],
        extendBody: true,
        bottomNavigationBuilder: (_, tabsRouter) {
          return CustomBottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onPressed: tabsRouter.setActiveIndex,
            labels: [
              S.of(context).home,
              S.of(context).categories,
              S.of(context).cart,
              S.of(context).profile,
            ],
          );
        },
      ),
    );
  }
}
