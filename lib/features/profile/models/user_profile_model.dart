import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 0)
class UserProfileModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final int coins;

  @HiveField(3)
  final List<String> unlockedStickers;

  @HiveField(4)
  final DateTime createdAt;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.coins,
    required this.unlockedStickers,
    required this.createdAt,
  });

  UserProfileModel copyWith({
    String? id,
    String? username,
    int? coins,
    List<String>? unlockedStickers,
    DateTime? createdAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      coins: coins ?? this.coins,
      unlockedStickers: unlockedStickers ?? this.unlockedStickers,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
