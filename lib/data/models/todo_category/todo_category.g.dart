// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoCategoryAdapter extends TypeAdapter<TodoCategory> {
  @override
  final int typeId = 0;

  @override
  TodoCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TodoCategory.personal;
      case 1:
        return TodoCategory.work;
      case 2:
        return TodoCategory.meeting;
      case 3:
        return TodoCategory.shopping;
      case 4:
        return TodoCategory.party;
      case 5:
        return TodoCategory.study;
      case 6:
        return TodoCategory.all;
      default:
        return TodoCategory.personal;
    }
  }

  @override
  void write(BinaryWriter writer, TodoCategory obj) {
    switch (obj) {
      case TodoCategory.personal:
        writer.writeByte(0);
        break;
      case TodoCategory.work:
        writer.writeByte(1);
        break;
      case TodoCategory.meeting:
        writer.writeByte(2);
        break;
      case TodoCategory.shopping:
        writer.writeByte(3);
        break;
      case TodoCategory.party:
        writer.writeByte(4);
        break;
      case TodoCategory.study:
        writer.writeByte(5);
        break;
      case TodoCategory.all:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
