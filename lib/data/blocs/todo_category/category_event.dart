part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class LoadCategory extends CategoryEvent {
  final TodoCategory category;

  LoadCategory({this.category = TodoCategory.all});
  @override
  List<Object?> get props => [category];
}
