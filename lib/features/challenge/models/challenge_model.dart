import 'package:hive/hive.dart';

part 'challenge_model.g.dart';

@HiveType(typeId: 1)
class ChallengeModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int durationDays;

  @HiveField(4)
  final DateTime startDate;

  @HiveField(5)
  final int streak;

  @HiveField(6)
  final List<DateTime> completedDates;

  @HiveField(7)
  final bool isCompleted;

  @HiveField(8)
  final int reminderHour;

  @HiveField(9)
  final int reminderMinute;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.startDate,
    required this.streak,
    required this.completedDates,
    required this.isCompleted,
    required this.reminderHour,
    required this.reminderMinute,
  });

  ChallengeModel copyWith({
    String? id,
    String? title,
    String? description,
    int? durationDays,
    DateTime? startDate,
    int? streak,
    List<DateTime>? completedDates,
    bool? isCompleted,
    int? reminderHour,
    int? reminderMinute,
  }) {
    return ChallengeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationDays: durationDays ?? this.durationDays,
      startDate: startDate ?? this.startDate,
      streak: streak ?? this.streak,
      completedDates: completedDates ?? this.completedDates,
      isCompleted: isCompleted ?? this.isCompleted,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
    );
  }
}
