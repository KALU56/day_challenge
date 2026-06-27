import 'package:go_router/go_router.dart';
import '../design_system/widgets/preview/design_system_preview.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DesignSystemPreview(),
    ),
  ],
);
