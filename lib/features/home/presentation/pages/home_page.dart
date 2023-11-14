import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/widgets/custom_curve_background.dart';
import 'package:jahiz/features/home/presentation/blocs/home_cubit.dart';
import 'package:jahiz/features/home/presentation/widgets/dynamic_list.dart';
import '../../../../core/blocs/slider_indicator_cubit.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/contained_button.dart';
import '../../../../core/widgets/no_elements_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Assets.images.jahezLogo.image(width: 70),
        // bottom: const _SearchTextFormField(),
        actions: [
          ContainedButton(
            icon: Assets.images.notification.svg(height: 22, width: 22),
            onPressed: () => context.pushRoute(const NotificationsRoute()),
            withShadow: false,
            backgroundColor: Colors.white,
            margin: const EdgeInsetsDirectional.only(end: 16.0),
          )
        ],
      ),
      body: BlocProvider(
        create: (_) => getIt<SliderIndicatorCubit>(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, state) {
            if (state is HomeLoadInProgress) {
              return const LinearProgressIndicator();
            }
            if (state is HomeLoadFailure) {
              return AppErrorWidget(
                  errorText: state.error,
                  onRetryClicked: context.read<HomeCubit>().getHomeBlocks);
            }
            if (state is HomeLoadEmpty) {
              return const NoElementsWidget();
            }
            return Stack(
              children: [
                CustomCurveBackground(
                    padding: const EdgeInsets.only(top: 24),
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundContainerborderRadius: null,
                    listContainerborderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    child: DynamicList(
                        homeBlocks: (state as HomeLoadSuccess).homeBlocks)),
                const _SearchTextFormField(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchTextFormField extends StatelessWidget
    implements PreferredSizeWidget {
  const _SearchTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                  flex: 3,
                  child: Text(
                    S.of(context).searchHint,
                    style: const TextStyle(fontSize: 18),
                  )),
              IconButton(onPressed: () {}, icon: Assets.images.search.svg()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
