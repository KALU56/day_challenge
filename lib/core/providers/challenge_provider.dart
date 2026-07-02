import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/challenge_model.dart';

class ChallengeState {
  final List<Challenge> challenges;
  final String activeChallengeId;
  final int coins;
  final int streak;

  const ChallengeState({
    required this.challenges,
    required this.activeChallengeId,
    required this.coins,
    required this.streak,
  });

  Challenge get activeChallenge =>
      challenges.firstWhere((c) => c.id == activeChallengeId);

  ChallengeState copyWith({
    List<Challenge>? challenges,
    String? activeChallengeId,
    int? coins,
    int? streak,
  }) {
    return ChallengeState(
      challenges: challenges ?? this.challenges,
      activeChallengeId: activeChallengeId ?? this.activeChallengeId,
      coins: coins ?? this.coins,
      streak: streak ?? this.streak,
    );
  }
}

class ChallengeNotifier extends StateNotifier<ChallengeState> {
  ChallengeNotifier() : super(_initialState);

  static final ChallengeState _initialState = ChallengeState(
    coins: 1240,
    streak: 5,
    activeChallengeId: '7_day',
    challenges: [
      Challenge(
        id: '1_day',
        name: '1-Day Focus Challenge',
        durationDays: 1,
        status: ChallengeStatus.completed,
        isPinned: false,
        dayStatuses: [DayStatus.completed],
      ),
      Challenge(
        id: '3_day',
        name: '3-Day Quick Habit',
        durationDays: 3,
        status: ChallengeStatus.active,
        isPinned: false,
        dayStatuses: [DayStatus.completed, DayStatus.completed, DayStatus.current],
      ),
      Challenge(
        id: '7_day',
        name: '7-Day Consistency Boost',
        durationDays: 7,
        status: ChallengeStatus.active,
        isPinned: true,
        dayStatuses: [
          DayStatus.completed,
          DayStatus.completed,
          DayStatus.completed,
          DayStatus.missed,
          DayStatus.completed,
          DayStatus.current,
          DayStatus.future,
        ],
      ),
      Challenge(
        id: '30_day',
        name: '30-Day Ultimate Transformation',
        durationDays: 30,
        status: ChallengeStatus.locked,
        isPinned: false,
        dayStatuses: List.generate(30, (index) {
          if (index < 12) return DayStatus.completed;
          if (index == 12) return DayStatus.missed;
          if (index < 20) return DayStatus.completed;
          if (index == 20) return DayStatus.current;
          return DayStatus.future;
        }),
      ),
    ],
  );

  void selectChallenge(String id) {
    state = state.copyWith(activeChallengeId: id);
  }

  void togglePin(String id) {
    final updatedChallenges = state.challenges.map((challenge) {
      if (challenge.id == id) {
        // Toggle the pin for target challenge
        return challenge.copyWith(isPinned: !challenge.isPinned);
      } else {
        // Only one challenge can be pinned at a time
        return challenge.copyWith(isPinned: false);
      }
    }).toList();

    state = state.copyWith(challenges: updatedChallenges);
  }

  void updateDayStatus(String challengeId, int dayIndex, DayStatus newStatus) {
    final updatedChallenges = state.challenges.map((challenge) {
      if (challenge.id == challengeId) {
        final newStatuses = List<DayStatus>.from(challenge.dayStatuses);
        if (dayIndex >= 0 && dayIndex < newStatuses.length) {
          newStatuses[dayIndex] = newStatus;
        }
        return challenge.copyWith(dayStatuses: newStatuses);
      }
      return challenge;
    }).toList();

    state = state.copyWith(challenges: updatedChallenges);
  }

  void addCoins(int amount) {
    state = state.copyWith(coins: state.coins + amount);
  }
}

final challengeProvider = StateNotifierProvider<ChallengeNotifier, ChallengeState>((ref) {
  return ChallengeNotifier();
});
