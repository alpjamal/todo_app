import 'package:hive/hive.dart';

part 'todo_category.g.dart';

@HiveType(typeId: 0)
enum TodoCategory {

  @HiveField(0)
  personal,

  @HiveField(1)
  work,

  @HiveField(2)
  meeting,

  @HiveField(3)
  shopping,

  @HiveField(4)
  party,

  @HiveField(5)
  study,

  @HiveField(6)
  all,
}
