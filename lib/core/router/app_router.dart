import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:jahiz/features/products/domain/entities/product.dart';
import '../../features/addresses/presentation/pages/addresses_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/categories/presentation/pages/categories_page.dart';
import '../../features/categories/presentation/pages/sub_categories_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/notifications/domain/entities/notification.dart';
import '../../features/notifications/presentation/pages/notification_details_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/orders/presentaion/pages/order_details_page.dart';
import '../../features/orders/presentaion/pages/order_history_page.dart';
import '../../features/checkout/presentation/pages/checkout_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/products/presentation/pages/product_details_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: CategoriesRoute.page),
          AutoRoute(page: ProfileRoute.page),
          AutoRoute(page: CartRoute.page),
        ]),
        AutoRoute(page: ProductDetailsRoute.page),
        AutoRoute(page: SubCategoriesRoute.page),
        AutoRoute(page: CheckoutRoute.page),
        AutoRoute(page: OrderHistoryRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: OrderDetailsRoute.page),
        AutoRoute(page: AddressesRoute.page),
        AutoRoute(page: NotificationsRoute.page),
        AutoRoute(page: NotificationDetailsRoute.page)
      ];
}
