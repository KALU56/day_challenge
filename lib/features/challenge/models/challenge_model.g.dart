// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallengeModelAdapter extends TypeAdapter<ChallengeModel> {
  @override
  final int typeId = 1;

  @override
  ChallengeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChallengeModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      durationDays: fields[3] as int,
      startDate: fields[4] as DateTime,
      streak: fields[5] as int,
      completedDates: (fields[6] as List).cast<DateTime>(),
      isCompleted: fields[7] as bool,
      reminderHour: fields[8] as int,
      reminderMinute: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChallengeModel obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.streak)
      ..writeByte(6)
      ..write(obj.completedDates)
      ..writeByte(7)
      ..write(obj.isCompleted)
      ..writeByte(8)
      ..write(obj.reminderHour)
      ..writeByte(9)
      ..write(obj.reminderMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
