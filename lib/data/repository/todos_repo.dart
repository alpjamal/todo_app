import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/data/models/todo_category.dart';

import '../models/todo.dart';

class TodosRepo {
  Future<dynamic> getTodos() async {
    List<Todo> todos = [];
    FirebaseFirestore.instance.collection('todos').snapshots().listen((data) {
      for (var item in data.docs) {
        var todo = Todo(
          id: item['id'],
          title: item['title'],
          dayTime: DateTime.parse(item['dayTime']),
          category: TodoCategory.values.firstWhere((e) => e.toString() == item['category']),
          isCompleted: item['isCompleted'],
        );
        todos.add(todo);
      }
    });
    return todos;
  }

  Future<void> addTodo(Todo todo) async {
    // String day = DateFormat('dd MM yyyy').format(todo.dayTime);
    FirebaseFirestore.instance.collection('todos').add(
      {
        'id': todo.id,
        'title': todo.title,
        'dayTime': todo.dayTime.toString(),
        'category': todo.category.toString(),
        'isCompleted': todo.isCompleted,
      },
    );
  }

  Future<dynamic> updateTodo(Todo todo) async {
    FirebaseFirestore.instance.collection('todos').add(
      {},
    );
  }
}
