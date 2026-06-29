import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'app/app.dart';
import 'core/constants/app_keys.dart';
import 'features/profile/models/user_profile_model.dart';
import 'features/challenge/models/challenge_model.dart';
import 'features/friend_challenge/models/friend_challenge_model.dart';
import 'features/friend_challenge/models/promise_model.dart';
import 'services/database/hive_db_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  final dbService = HiveDbServiceImpl();
  await dbService.init();

  try {
    // Register generated adapters
    Hive.registerAdapter(UserProfileModelAdapter());
    Hive.registerAdapter(ChallengeModelAdapter());
    Hive.registerAdapter(FriendChallengeModelAdapter());
    Hive.registerAdapter(PromiseModelAdapter());

    // Open core boxes used across the app
    await dbService.openBox<UserProfileModel>(AppKeys.userProfileBox);
    await dbService.openBox<ChallengeModel>(AppKeys.challengesBox);
    await dbService.openBox<dynamic>(AppKeys.settingsBox);
  } catch (e, st) {
    // If initialization fails, log the error and continue (app can still run)
    // Repositories should handle absent boxes gracefully.
    debugPrint('Hive initialization warning: $e');
    debugPrint('$st');
  }

  runApp(const DayChallengeApp());
}
