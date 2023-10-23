import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/blocs/slider_indicator_cubit.dart';
import 'package:jahiz/core/widgets/app_cached_network_image.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/core/widgets/contained_button.dart';
import 'package:jahiz/core/widgets/no_elements_widget.dart';
import 'package:jahiz/features/app_settings/presentation/bloc/app_settings_cubit.dart';
import 'package:jahiz/features/products/presentation/bloc/home/home_cubit.dart';
import 'package:jahiz/features/products/presentation/widgets/home/dynamic_list.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';
import '../../../../core/widgets/sign_up_login_bottom_sheet.dart';
import '../../../app_settings/domain/entities/app_settings.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
            height: 40,
            child: BlocBuilder<AppSettingsCubit, AppSettings?>(
                builder: (context, state) {
              if (state != null) {
                return AppCachedNetworkImage(imageUrl: state.appLogo);
              }
              return const SizedBox.shrink();
            })),
        bottom: const _SearchTextFormField(),
        actions: [
          ContainedButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              showSignUpLoginBottomSheet(context);
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(bottom: 2, top: 5, right: 8, left: 8),
              hintText: S.of(context).searchHint,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
