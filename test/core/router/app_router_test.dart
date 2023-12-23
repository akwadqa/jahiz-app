import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/router/app_router.dart';

void main() {
  group('AppRouter', () {
    test('Check if all routes are defined', () {
      final appRouter = AppRouter();

      final routes = appRouter.routes;

      expect(routes, hasLength(10));

      expect(routes, contains(isA<AutoRoute>()));
    });

    test('Check if initial route is correct', () {
      final appRouter = AppRouter();

      final initialRoute = appRouter.routes[0];

      expect(
        initialRoute.toString(),
        AutoRoute(page: MainRoute.page, initial: true).toString(),
      );
    });
  });
}
