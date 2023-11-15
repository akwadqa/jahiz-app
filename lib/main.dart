import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'core/app_observer.dart';
import 'core/blocs/selected_language_cubit.dart';
import 'features/auth/application/auth_cubit.dart';
import 'features/cart/application/cart_count_cubit.dart';
import 'features/cart/presentation/bloc/cart_cubit.dart';
import 'features/cart/presentation/bloc/update_cart/update_cart_cubit.dart';
import 'features/notifications/application/notifications_service.dart';
import 'injection_container.dart';

import 'features/app_settings/presentation/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/app_settings/presentation/bloc/app_settings_cubit.dart';
import 'features/products/presentation/bloc/add_to_cart/add_to_cart_cubit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await init();
  await getIt<NotificationsService>().init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = AppObserver();
  runApp(Phoenix(
    child: MultiBlocProvider(providers: [
      BlocProvider(create: (context) => getIt<AppSettingsCubit>()),
      BlocProvider(create: (context) => getIt<AuthCubit>()),
      BlocProvider(create: (_) => getIt<AddToCartCubit>()),
      BlocProvider(create: (_) => getIt<SelectedLanguageCubit>()),
      BlocProvider(lazy: false, create: (_) => getIt<CartCubit>()..getCart()),
      BlocProvider(create: (_) => getIt<CartCountCubit>()..init()),
      BlocProvider(create: (_) => getIt<UpdateCartCubit>()),
    ], child: const App()),
  ));
}
