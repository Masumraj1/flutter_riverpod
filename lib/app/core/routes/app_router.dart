import 'package:go_router/go_router.dart';
import 'package:riverpod_prectice/app/all_provider/state_provider/state_provider.dart';

import 'route_path.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.counterPage.addBasePath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: RoutePath.counterPage,
        path: RoutePath.counterPage.addBasePath,
        builder: (context, state) =>  CounterPage(),
      ),

    ],
  );

  static GoRouter get route => initRoute;
}
