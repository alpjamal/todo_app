import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/models/todo_category.dart';
import 'package:todo_app/data/todos/todos_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _subscription;

  CategoryBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(CategoryLoading()) {
    on<LoadCategory>(_loadCategory);

    _subscription = todosBloc.stream.listen((state) {
      add(LoadCategory());
    });
  }
  _loadCategory(LoadCategory event, Emitter<CategoryState> emit) {
    final state = _todosBloc.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return event.category == todo.category;
      }).toList();
    }
  }
}
