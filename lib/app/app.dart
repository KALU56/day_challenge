import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'routes.dart';

class DayChallengeApp extends StatelessWidget {
  const DayChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DayChallenge',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
