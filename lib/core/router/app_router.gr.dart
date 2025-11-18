// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddressesPage]
class AddressesRoute extends PageRouteInfo<void> {
  const AddressesRoute({List<PageRouteInfo>? children})
      : super(AddressesRoute.name, initialChildren: children);

  static const String name = 'AddressesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AddressesPage());
    },
  );
}

/// generated route for
/// [CartPage]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
      : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CartPage());
    },
  );
}

/// generated route for
/// [CategoriesPage]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CategoriesPage());
    },
  );
}

/// generated route for
/// [CheckoutPage]
class CheckoutRoute extends PageRouteInfo<void> {
  const CheckoutRoute({List<PageRouteInfo>? children})
      : super(CheckoutRoute.name, initialChildren: children);

  static const String name = 'CheckoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CheckoutPage());
    },
  );
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const EditProfilePage());
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [NotificationDetailsPage]
class NotificationDetailsRoute
    extends PageRouteInfo<NotificationDetailsRouteArgs> {
  NotificationDetailsRoute({
    Key? key,
    required Notification notification,
    List<PageRouteInfo>? children,
  }) : super(
          NotificationDetailsRoute.name,
          args: NotificationDetailsRouteArgs(
            key: key,
            notification: notification,
          ),
          initialChildren: children,
        );

  static const String name = 'NotificationDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationDetailsRouteArgs>();
      return NotificationDetailsPage(
        key: args.key,
        notification: args.notification,
      );
    },
  );
}

class NotificationDetailsRouteArgs {
  const NotificationDetailsRouteArgs({this.key, required this.notification});

  final Key? key;

  final Notification notification;

  @override
  String toString() {
    return 'NotificationDetailsRouteArgs{key: $key, notification: $notification}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationDetailsRouteArgs) return false;
    return key == other.key && notification == other.notification;
  }

  @override
  int get hashCode => key.hashCode ^ notification.hashCode;
}

/// generated route for
/// [NotificationsPage]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
      : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const NotificationsPage());
    },
  );
}

/// generated route for
/// [OrderDetailsPage]
class OrderDetailsRoute extends PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    Key? key,
    required String salesOrderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(key: key, salesOrderId: salesOrderId),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailsRouteArgs>();
      return WrappedRoute(
        child: OrderDetailsPage(key: args.key, salesOrderId: args.salesOrderId),
      );
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, required this.salesOrderId});

  final Key? key;

  final String salesOrderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, salesOrderId: $salesOrderId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderDetailsRouteArgs) return false;
    return key == other.key && salesOrderId == other.salesOrderId;
  }

  @override
  int get hashCode => key.hashCode ^ salesOrderId.hashCode;
}

/// generated route for
/// [OrderHistoryPage]
class OrderHistoryRoute extends PageRouteInfo<void> {
  const OrderHistoryRoute({List<PageRouteInfo>? children})
      : super(OrderHistoryRoute.name, initialChildren: children);

  static const String name = 'OrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const OrderHistoryPage());
    },
  );
}

/// generated route for
/// [ProductDetailsPage]
class ProductDetailsRoute extends PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    Key? key,
    required Product product,
    required String heroTag,
    List<PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            product: product,
            heroTag: heroTag,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return WrappedRoute(
        child: ProductDetailsPage(
          key: args.key,
          product: args.product,
          heroTag: args.heroTag,
        ),
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.product,
    required this.heroTag,
  });

  final Key? key;

  final Product product;

  final String heroTag;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product, heroTag: $heroTag}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailsRouteArgs) return false;
    return key == other.key &&
        product == other.product &&
        heroTag == other.heroTag;
  }

  @override
  int get hashCode => key.hashCode ^ product.hashCode ^ heroTag.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [SubCategoriesPage]
class SubCategoriesRoute extends PageRouteInfo<SubCategoriesRouteArgs> {
  SubCategoriesRoute({
    Key? key,
    required String categoryId,
    List<PageRouteInfo>? children,
  }) : super(
          SubCategoriesRoute.name,
          args: SubCategoriesRouteArgs(key: key, categoryId: categoryId),
          initialChildren: children,
        );

  static const String name = 'SubCategoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubCategoriesRouteArgs>();
      return WrappedRoute(
        child: SubCategoriesPage(key: args.key, categoryId: args.categoryId),
      );
    },
  );
}

class SubCategoriesRouteArgs {
  const SubCategoriesRouteArgs({this.key, required this.categoryId});

  final Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'SubCategoriesRouteArgs{key: $key, categoryId: $categoryId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SubCategoriesRouteArgs) return false;
    return key == other.key && categoryId == other.categoryId;
  }

  @override
  int get hashCode => key.hashCode ^ categoryId.hashCode;
}
