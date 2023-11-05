import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/blocs/slider_indicator_cubit.dart';
import 'package:jahiz/core/gen/assets.gen.dart';
import 'package:jahiz/core/router/app_router.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/core/widgets/contained_button.dart';
import 'package:jahiz/core/widgets/no_elements_widget.dart';
import 'package:jahiz/features/products/presentation/bloc/home/home_cubit.dart';
import 'package:jahiz/features/products/presentation/widgets/home/dynamic_list.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';
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
        bottom: const _SearchTextFormField(),
        actions: [
          ContainedButton(
            icon: Assets.images.notification.svg(),
            onPressed: () {
              // Todo Check if user logged in or not
              context.pushRoute(const NotificationRoute());
            },
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
            return DynamicList(
                homeBlocks: (state as HomeLoadSuccess).homeBlocks);
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
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          height: 30,
          decoration: const BoxDecoration(
              color: AppColors.whiteSmoke,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(bottom: 2, top: 5, right: 8, left: 8),
              hintText: S.of(context).searchHint,
              suffixIcon: IconButton(
                  onPressed: () {}, icon: Assets.images.search.svg()),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
