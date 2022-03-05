// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryAdapter extends TypeAdapter<Entry> {
  @override
  final int typeId = 2;

  @override
  Entry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entry(
      id: fields[0] as String,
      diaryId: fields[1] as String,
      title: fields[2] as String,
      createdAt: fields[3] as DateTime,
      color:
          Color(int.parse(fields[4].split('(0x')[1].split(')')[0], radix: 16)),
      data: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Entry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.diaryId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.color.toString())
      ..writeByte(5)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
