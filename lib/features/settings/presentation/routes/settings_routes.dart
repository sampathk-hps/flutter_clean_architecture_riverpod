import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../screens/settings_screen.dart';

final List<RouteBase> settingsRoutes = [
  GoRoute(
    path: RoutePaths.settings,
    builder: (context, state) => const SettingsScreen(),
  ),
];
