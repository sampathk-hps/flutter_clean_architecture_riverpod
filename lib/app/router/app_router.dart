import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/routes/auth_routes.dart';
import '../../features/dashboard/presentation/routes/dashboard_routes.dart';
import '../../features/jobs/presentation/routes/jobs_routes.dart';
import '../../features/settings/presentation/routes/settings_routes.dart';
import 'route_paths.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.login,
    routes: [
      ...authRoutes,
      ...dashboardRoutes,
      ...jobRoutes,
      ...settingsRoutes,
    ],
  );
});
