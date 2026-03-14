import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../screens/login_screen.dart';

final List<RouteBase> authRoutes = [
  GoRoute(
    path: RoutePaths.login,
    builder: (context, state) => const LoginScreen(),
  ),
];
