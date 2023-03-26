part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<Todo> todos;
  final TodoCategory category;
  CategoryLoaded({
    required this.todos,
    this.category = TodoCategory.all,
  });
  @override
  List<Object?> get props => [todos, category];
}
