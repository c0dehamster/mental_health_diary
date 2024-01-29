// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodRecordAdapter extends TypeAdapter<MoodRecord> {
  @override
  final int typeId = 1;

  @override
  MoodRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodRecord(
      value: fields[0] as int,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MoodRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
