import 'package:go_router/go_router.dart';

import '../features/home/presentation/screens/app_shell.dart';
import '../features/challenge/presentation/screens/challenge_create_screen.dart';
import '../features/challenge/presentation/screens/challenge_detail_screen.dart';
import '../features/challenge/presentation/screens/challenge_list_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AppShell()),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/challenges',
      builder: (context, state) => const ChallengeListScreen(),
    ),
    GoRoute(
      path: '/challenges/create',
      builder: (context, state) => const ChallengeCreateScreen(),
    ),
    GoRoute(
      path: '/challenges/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChallengeDetailScreen(challengeId: id);
      },
    ),
  ],
);
