import 'package:dio/dio.dart';
import 'package:jahiz/features/cart/application/cart_count_cubit.dart';
import 'package:jahiz/features/cart/application/cart_service.dart';
import 'package:jahiz/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:jahiz/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:jahiz/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:jahiz/features/checkout/presentation/bloc/place_order/place_order_cubit.dart';
import 'package:jahiz/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:jahiz/features/notification/data/repositories/notifications_repository_impl.dart';
import 'package:jahiz/features/notification/domain/repositories/notification_repository.dart';
import 'package:jahiz/features/notification/domain/usecases/get_notification.dart';
import 'package:jahiz/features/notification/presentation/bloc/get_notifications/get_notifictions_cubit.dart';
import 'package:jahiz/features/orders/domain/usecases/get_sales_order_details.dart';
import 'package:jahiz/features/orders/domain/usecases/get_sales_orders.dart';
import 'package:jahiz/features/orders/presentaion/bloc/sales_order_details/sales_order_details_cubit.dart';
import 'package:jahiz/features/orders/presentaion/bloc/sales_orders/cubit/sales_orders_cubit.dart';
import 'package:jahiz/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:jahiz/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:jahiz/features/profile/domain/repositories/profile_repository.dart';
import 'package:jahiz/features/profile/domain/usecases/get_profile_details.dart';
import 'package:jahiz/features/profile/domain/usecases/update_profile_details.dart';
import 'package:jahiz/features/profile/presentation/bloc/edit_profile/edit_profile_cubit.dart';
import 'package:jahiz/features/profile/presentation/bloc/profile_details/profile_details_cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jahiz/core/network/network_service.dart';
import 'package:jahiz/core/network/network_info.dart';
import 'package:jahiz/features/addresses/data/datasources/addresses_remote_data_source.dart';
import 'package:jahiz/features/addresses/data/repositories/addresses_repository_impl.dart';
import 'package:jahiz/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:jahiz/features/addresses/domain/usecases/add_update_address.dart';
import 'package:jahiz/features/addresses/domain/usecases/get_cities.dart';
import 'package:jahiz/features/addresses/presentation/bloc/add_update_address/add_update_address_cubit.dart';
import 'package:jahiz/features/addresses/presentation/bloc/get_cities/get_cities_cubit.dart';
import 'package:jahiz/features/app_settings/presentation/bloc/app_settings_cubit.dart';
import 'package:jahiz/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:jahiz/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:jahiz/features/auth/domain/repositories/auth_repository.dart';
import 'package:jahiz/features/auth/domain/usecases/check_user_validation.dart';
import 'package:jahiz/features/auth/domain/usecases/login.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/features/auth/presentation/bloc/check_user_validation/check_user_validation_cubit.dart';
import 'package:jahiz/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:jahiz/features/auth/presentation/bloc/register/register_cubit.dart';
import 'package:jahiz/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:jahiz/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:jahiz/features/cart/domain/repositories/cart_repository.dart';
import 'package:jahiz/features/checkout/domain/usecases/place_order.dart';
import 'package:jahiz/features/payment/domain/repositories/payment_repository.dart';
import 'package:jahiz/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:jahiz/features/cart/presentation/bloc/update_cart/update_cart_cubit.dart';
import 'package:jahiz/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:jahiz/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:jahiz/features/categories/domain/repositories/categories_repository.dart';
import 'package:jahiz/features/categories/domain/usecases/get_categories.dart';
import 'package:jahiz/features/products/data/datasources/home_remote_data_source.dart';
import 'package:jahiz/features/products/data/repositories/home_repository_impl.dart';
import 'package:jahiz/features/products/domain/repositories/home_repository.dart';
import 'package:jahiz/features/products/domain/usecases/get_home_blocks.dart';
import 'package:jahiz/features/products/presentation/bloc/add_detailed_product_to_cart/add_detailed_product_to_cart_cubit.dart';
import 'package:jahiz/features/products/presentation/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:jahiz/features/products/presentation/bloc/home/home_cubit.dart';
import 'package:jahiz/core/blocs/slider_indicator_cubit.dart';
import 'core/blocs/selected_language_cubit.dart';
import 'features/addresses/domain/usecases/get_addresses.dart';
import 'features/addresses/presentation/bloc/get_addresses/get_addresses_cubit.dart';
import 'features/app_settings/data/datasources/app_settings_remote_data_source.dart';
import 'features/app_settings/data/repositories/app_settings_repository_impl.dart';
import 'features/app_settings/domain/repositories/app_settings_repository.dart';
import 'features/app_settings/domain/usecases/get_app_settings.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/orders/data/datasources/orders_remote_data_source.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';
import 'features/orders/domain/repositories/orders_repository.dart';
import 'features/payment/data/datasources/payment_remote_data_source.dart';
import 'features/payment/data/repositories/payment_repository_impl.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/payment/domain/usecases/get_payment_methods.dart';
import 'features/cart/domain/usecases/update_cart.dart';
import 'features/payment/presentation/bloc/payment_methods_cubit.dart';
import 'features/categories/presentation/bloc/categories/categories_cubit.dart';
import 'features/categories/presentation/bloc/sub_categories/sub_categories_cubit.dart';
import 'features/products/data/datasources/products_remote_data_source.dart';
import 'features/products/data/repositories/products_repository_impl.dart';
import 'features/products/domain/repositories/products_repository.dart';
import 'features/products/domain/usecases/get_detailed_product.dart';
import 'features/products/presentation/bloc/detailed_product/detailed_product_cubit.dart';
import 'features/products/presentation/bloc/price_modifier/price_modifier_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  ///Core
  getIt.registerLazySingleton(() => SelectedLanguageCubit(getIt()));

  //!Features - home
  //Bloc
  getIt.registerFactory(() => HomeCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetHomeBlocksUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()));

  //!Features - products
  //Bloc
  getIt.registerFactoryParam<DetailedProductCubit, String, void>(
      (productId, _) => DetailedProductCubit(getIt(), productId));
  getIt.registerFactory(() => PriceModifierCubit());
  getIt.registerFactory(() => AddDetailedProductToCartCubit());
  getIt.registerFactory(() => AddToCartCubit());

  //UseCases
  getIt.registerLazySingleton(() => GetDetailedProductUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(getIt()));

  //!Features - auth
  //Bloc
  getIt.registerFactory(() => CheckUserValidationCubit(getIt()));
  getIt.registerLazySingleton(() => AuthCubit(getIt()));
  getIt.registerFactory(() => RegisterCubit(getIt(), getIt()));
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));

  //UseCases
  getIt.registerLazySingleton(() => CheckUserValidationUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()));

  //!Features - app settings
  //Bloc
  getIt.registerLazySingleton(() => AppSettingsCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetAppSettingsUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<AppSettingsRepository>(
      () => AppSettingsRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<AppSettingsRemoteDataSource>(
      () => AppSettingsRemoteDataSourceImpl(getIt()));

  //!Features - categories
  //Bloc
  getIt.registerFactory(() => CategoriesCubit(getIt()));
  getIt.registerFactoryParam<SubCategoriesCubit, String, void>(
      (categoryId, _) => SubCategoriesCubit(getIt(), categoryId));

  //UseCases
  getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(getIt()));

  //!Features - addresses
  //Bloc
  getIt.registerFactory(() => AddUpdateAddressCubit(getIt()));
  getIt.registerFactory(() => GetCitiesCubit(getIt()));
  getIt.registerFactory(() => GetAddressesCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetCitiesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddUpdateAddressUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAddressesUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<AddressesRepository>(
      () => AddressesRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<AddressesRemoteDataSource>(
      () => AddressesRemoteDataSourceImpl(getIt()));

  //!Features - notifications
  //Bloc
  getIt.registerFactory(() => GetNotificationsCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetNotificationUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(getIt()));

  //!Features - cart
  //Bloc
  getIt.registerLazySingleton(() => CartCubit(getIt(), getIt()));
  getIt.registerLazySingleton(() => UpdateCartCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetCartUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateCartUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(getIt()));

  //Applicaiton
  getIt.registerFactory<CartCountCubit>(() => CartCountCubit(getIt()));
  getIt.registerFactory(() => CartService(getIt(), getIt()));

  //!Features - payment
  //Bloc
  getIt.registerFactory(() => PaymentMethodsCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetPaymentMethodsUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(getIt()));

  //!Features - orders
  //Bloc
  getIt.registerFactory(() => SalesOrdersCubit(getIt()));
  getIt.registerFactory(() => SalesOrderDetailsCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetSalesOrdersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSalesOrderDetailsUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<OrdersRepository>(
      () => OrdersRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<OrdersRemoteDataSource>(
      () => OrdersRemoteDataSourceImpl(getIt()));

  //!Features - checkout
  //Bloc
  getIt.registerFactory(() => PlaceOrderCubit(getIt()));
  
  //UseCases
  getIt.registerLazySingleton(() => PlaceOrderUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<CheckoutRemoteDataSource>(
      () => CheckoutRemoteDataSourceImpl(getIt()));

  //!Features - profile
  //Bloc
  getIt.registerFactory(() => EditProfileCubit(getIt()));
  getIt.registerFactory(() => ProfileDetailsCubit(getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetProfileDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileDetailsUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt(), getIt()));

  //DataSources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(getIt()));

  //!Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerFactory(() => SliderIndicatorCubit());

  //!External
  getIt.registerLazySingleton<NetworkService<Response>>(
      () => DioNetworkService(getIt()));
  getIt.registerLazySingleton(() => DioAppInterceptors());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  getIt.registerLazySingleton(() => packageInfo);
}
