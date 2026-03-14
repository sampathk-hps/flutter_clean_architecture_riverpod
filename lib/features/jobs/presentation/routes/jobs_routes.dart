import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../screens/job_detail_screen.dart';
import '../screens/job_list_screen.dart';
import '../screens/job_update_screen.dart';

final List<RouteBase> jobRoutes = [
  GoRoute(
    path: RoutePaths.jobs,
    builder: (context, state) => const JobListScreen(),
  ),
  GoRoute(
    path: RoutePaths.jobDetails,
    builder: (context, state) {
      final jobId = state.pathParameters['jobId']!;
      return JobDetailScreen(jobId: jobId);
    },
  ),
  GoRoute(
    path: RoutePaths.jobUpdate,
    builder: (context, state) {
      final jobId = state.pathParameters['jobId']!;
      return JobUpdateScreen(jobId: jobId);
    },
  ),
];
