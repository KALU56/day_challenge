import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';

class DayChallengeApp extends StatelessWidget {
  const DayChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'DayChallenge',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode
            .dark, // change to ThemeMode.system once Settings screen exists

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
