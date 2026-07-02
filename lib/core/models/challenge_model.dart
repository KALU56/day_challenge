enum DayStatus {
  completed,
  missed,
  current,
  future,
}

enum ChallengeStatus {
  active,
  locked,
  completed,
}

class Challenge {
  final String id;
  final String name;
  final int durationDays;
  final ChallengeStatus status;
  final bool isPinned;
  final List<DayStatus> dayStatuses;
  final String? notes; // optional day details/notes

  const Challenge({
    required this.id,
    required this.name,
    required this.durationDays,
    required this.status,
    required this.isPinned,
    required this.dayStatuses,
    this.notes,
  });

  double get progress {
    if (dayStatuses.isEmpty) return 0.0;
    final completedCount = dayStatuses.where((status) => status == DayStatus.completed).length;
    return completedCount / durationDays;
  }

  Challenge copyWith({
    String? id,
    String? name,
    int? durationDays,
    ChallengeStatus? status,
    bool? isPinned,
    List<DayStatus>? dayStatuses,
    String? notes,
  }) {
    return Challenge(
      id: id ?? this.id,
      name: name ?? this.name,
      durationDays: durationDays ?? this.durationDays,
      status: status ?? this.status,
      isPinned: isPinned ?? this.isPinned,
      dayStatuses: dayStatuses ?? this.dayStatuses,
      notes: notes ?? this.notes,
    );
  }
}
