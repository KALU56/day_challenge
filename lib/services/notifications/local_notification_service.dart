import 'package:flutter/material.dart';

abstract class LocalNotificationService {
  Future<void> init();
  Future<void> scheduleDailyReminder({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  });
  Future<void> cancelReminder(int id);
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  });
}
