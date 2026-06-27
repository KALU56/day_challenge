// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromiseModelAdapter extends TypeAdapter<PromiseModel> {
  @override
  final int typeId = 3;

  @override
  PromiseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PromiseModel(
      requestDate: fields[0] as DateTime,
      isAccepted: fields[1] as bool,
      firstTaskCompleted: fields[2] as bool,
      secondTaskCompleted: fields[3] as bool,
      dueDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PromiseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.requestDate)
      ..writeByte(1)
      ..write(obj.isAccepted)
      ..writeByte(2)
      ..write(obj.firstTaskCompleted)
      ..writeByte(3)
      ..write(obj.secondTaskCompleted)
      ..writeByte(4)
      ..write(obj.dueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromiseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
