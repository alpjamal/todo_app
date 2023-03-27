import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/todo_category.dart';
import '/../../utils/constants.dart';
part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorInitial());

  TodoCategory? _selectedCategory;
  get selectedCategory => _selectedCategory;

  select(TodoCategory? category) => _selectedCategory = category;

  getColor(TodoCategory category) {
    if (category == TodoCategory.personal) {
      return TodoColor.personal;
    } else if (category == TodoCategory.work) {
      return TodoColor.work;
    } else if (category == TodoCategory.meeting) {
      return TodoColor.meeting;
    } else if (category == TodoCategory.party) {
      return TodoColor.party;
    } else if (category == TodoCategory.shopping) {
      return TodoColor.shopping;
    } else if (category == TodoCategory.study) {
      return TodoColor.study;
    }
  }

  getBellColor(DateTime dateTime) {
    Duration diff = dateTime.difference(DateTime.now());
    dateTime.difference(DateTime.now()).inHours > 5;
    return diff.inHours > 5 ? Colors.grey : Colors.amber;
  }
}
