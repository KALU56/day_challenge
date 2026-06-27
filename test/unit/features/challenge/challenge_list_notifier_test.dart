import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:day_challenge/core/constants/app_keys.dart';
import 'package:day_challenge/features/challenge/models/challenge_model.dart';
import 'package:day_challenge/features/challenge/repositories/challenge_repository_impl.dart';
import 'package:day_challenge/features/challenge/view_models/challenge_list_notifier.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = Directory.systemTemp.createTempSync(
      'day_challenge_challenge_test_',
    );
    Hive.init(tempDir.path);
    Hive.registerAdapter(ChallengeModelAdapter());
    if (Hive.isBoxOpen(AppKeys.challengesBox)) {
      await Hive.box(AppKeys.challengesBox).close();
    }
    await Hive.openBox<ChallengeModel>(AppKeys.challengesBox);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
    if (await tempDir.exists()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('ChallengeListNotifier creates and loads a challenge', () async {
    final repo = ChallengeRepositoryImpl();
    final notifier = ChallengeListNotifier(repo);

    await Future.delayed(const Duration(milliseconds: 200));

    final model = ChallengeModel(
      id: 'challenge-1',
      title: 'Read 20 pages',
      description: 'Daily reading habit',
      durationDays: 30,
      startDate: DateTime.now(),
      streak: 0,
      completedDates: [],
      isCompleted: false,
      reminderHour: 20,
      reminderMinute: 0,
    );

    await notifier.create(model);

    expect(notifier.state.value, isNotNull);
    expect(notifier.state.value!.length, 1);
    expect(notifier.state.value!.first.title, 'Read 20 pages');
  });
}
