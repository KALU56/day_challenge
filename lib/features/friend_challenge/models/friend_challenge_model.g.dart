// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_challenge_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendChallengeModelAdapter extends TypeAdapter<FriendChallengeModel> {
  @override
  final int typeId = 2;

  @override
  FriendChallengeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FriendChallengeModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      durationDays: fields[3] as int,
      startDate: fields[4] as DateTime,
      isCompleted: fields[5] as bool,
      challengerId: fields[6] as String,
      opponentId: fields[7] as String,
      challengerStreak: fields[8] as int,
      opponentStreak: fields[9] as int,
      challengerCompletedDates: (fields[10] as List).cast<DateTime>(),
      opponentCompletedDates: (fields[11] as List).cast<DateTime>(),
      activePromise: fields[12] as PromiseModel?,
      freezesReceivedToday: fields[13] as int,
      lastFreezeDate: fields[14] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, FriendChallengeModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.durationDays)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.challengerId)
      ..writeByte(7)
      ..write(obj.opponentId)
      ..writeByte(8)
      ..write(obj.challengerStreak)
      ..writeByte(9)
      ..write(obj.opponentStreak)
      ..writeByte(10)
      ..write(obj.challengerCompletedDates)
      ..writeByte(11)
      ..write(obj.opponentCompletedDates)
      ..writeByte(12)
      ..write(obj.activePromise)
      ..writeByte(13)
      ..write(obj.freezesReceivedToday)
      ..writeByte(14)
      ..write(obj.lastFreezeDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendChallengeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
