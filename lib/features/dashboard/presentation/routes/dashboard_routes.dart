import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../screens/dashboard_screen.dart';

final List<RouteBase> dashboardRoutes = [
  GoRoute(
    path: RoutePaths.dashboard,
    builder: (context, state) => const DashboardScreen(),
  ),
];
