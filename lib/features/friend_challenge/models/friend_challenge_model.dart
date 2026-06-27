import 'package:hive/hive.dart';
import 'promise_model.dart';

part 'friend_challenge_model.g.dart';

@HiveType(typeId: 2)
class FriendChallengeModel extends HiveObject {
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
  final bool isCompleted;

  @HiveField(6)
  final String challengerId;

  @HiveField(7)
  final String opponentId;

  @HiveField(8)
  final int challengerStreak;

  @HiveField(9)
  final int opponentStreak;

  @HiveField(10)
  final List<DateTime> challengerCompletedDates;

  @HiveField(11)
  final List<DateTime> opponentCompletedDates;

  @HiveField(12)
  final PromiseModel? activePromise;

  @HiveField(13)
  final int freezesReceivedToday;

  @HiveField(14)
  final DateTime? lastFreezeDate;

  FriendChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.startDate,
    required this.isCompleted,
    required this.challengerId,
    required this.opponentId,
    required this.challengerStreak,
    required this.opponentStreak,
    required this.challengerCompletedDates,
    required this.opponentCompletedDates,
    this.activePromise,
    required this.freezesReceivedToday,
    this.lastFreezeDate,
  });

  FriendChallengeModel copyWith({
    String? id,
    String? title,
    String? description,
    int? durationDays,
    DateTime? startDate,
    bool? isCompleted,
    String? challengerId,
    String? opponentId,
    int? challengerStreak,
    int? opponentStreak,
    List<DateTime>? challengerCompletedDates,
    List<DateTime>? opponentCompletedDates,
    PromiseModel? activePromise,
    int? freezesReceivedToday,
    DateTime? lastFreezeDate,
  }) {
    return FriendChallengeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationDays: durationDays ?? this.durationDays,
      startDate: startDate ?? this.startDate,
      isCompleted: isCompleted ?? this.isCompleted,
      challengerId: challengerId ?? this.challengerId,
      opponentId: opponentId ?? this.opponentId,
      challengerStreak: challengerStreak ?? this.challengerStreak,
      opponentStreak: opponentStreak ?? this.opponentStreak,
      challengerCompletedDates: challengerCompletedDates ?? this.challengerCompletedDates,
      opponentCompletedDates: opponentCompletedDates ?? this.opponentCompletedDates,
      activePromise: activePromise ?? this.activePromise,
      freezesReceivedToday: freezesReceivedToday ?? this.freezesReceivedToday,
      lastFreezeDate: lastFreezeDate ?? this.lastFreezeDate,
    );
  }
}
