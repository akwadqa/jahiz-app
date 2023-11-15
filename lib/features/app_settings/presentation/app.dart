import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../core/router/app_router.dart';
import 'bloc/app_settings_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../core/app_constants.dart';
import '../../../core/blocs/selected_language_cubit.dart';
import '../../../core/theme/app_theme.dart';

import '../domain/entities/app_settings.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedLanguageCubit, String>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        Phoenix.rebirth(context);
      },
      builder: (context, lang) {
        return BlocBuilder<AppSettingsCubit, AppSettings?>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: _appRouter.config(),
              debugShowCheckedModeBanner: false,
              title: AppConstants.appTitle,
              theme: AppTheme.lightTheme("#7A60D2").copyWith(
                  pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              })),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(lang, ''),
              onGenerateTitle: (context) => S.of(context).appTitle,
            );
          },
        );
      },
    );
  }
}
