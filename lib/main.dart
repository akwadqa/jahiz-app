import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/app_observer.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/firebase_options.dart';
import 'package:jahiz/injection_container.dart';

import 'features/app_settings/presentation/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/app_settings/presentation/bloc/app_settings_cubit.dart';
import 'features/products/presentation/bloc/add_to_cart/add_to_cart_cubit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await FCMConfig.instance.init(
    options: DefaultFirebaseOptions.currentPlatform,
    defaultAndroidChannel: const AndroidNotificationChannel(
      'high_importance_channel',
      'Fcm config',
      importance: Importance.high,
    ),
  );
  await init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = AppObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => getIt<AppSettingsCubit>()),
    BlocProvider(create: (context) => getIt<AuthCubit>()),
    BlocProvider(create: (_) => getIt<AddToCartCubit>()),
    BlocProvider(create: (_) => getIt<SelectedLanguageCubit>())
  ], child: const App()));
}
