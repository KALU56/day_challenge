import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:day_challenge/core/constants/app_keys.dart';
import 'package:day_challenge/features/profile/models/user_profile_model.dart';
import 'package:day_challenge/features/profile/repositories/profile_repository_impl.dart';
import 'package:day_challenge/features/profile/view_models/profile_notifier.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = Directory.systemTemp.createTempSync('day_challenge_test_');
    Hive.init(tempDir.path);
    // register adapters
    Hive.registerAdapter(UserProfileModelAdapter());
    // ensure any existing box closed, then open typed box
    if (Hive.isBoxOpen(AppKeys.userProfileBox)) {
      await Hive.box(AppKeys.userProfileBox).close();
    }
    await Hive.openBox<UserProfileModel>(AppKeys.userProfileBox);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
    if (await tempDir.exists()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('ProfileNotifier loads null when empty and saves user', () async {
    final repo = ProfileRepositoryImpl();
    final notifier = ProfileNotifier(repo);

    // wait for initial load
    await Future.delayed(const Duration(milliseconds: 200));

    expect(notifier.state.value, isNull);

    final user = UserProfileModel(
      id: 'test-id',
      username: 'tester',
      coins: 5,
      unlockedStickers: [],
      createdAt: DateTime.now(),
    );

    await notifier.save(user);

    expect(notifier.state.value, isNotNull);
    expect(notifier.state.value!.username, equals('tester'));
    expect(notifier.state.value!.coins, equals(5));
  });
}
