import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/data/models/todo_category.dart';

import '../models/todo.dart';

class TodosRepo {
  Future<dynamic> getTodos() async {
    List<Todo> todos = [];
    final snapshot = await FirebaseFirestore.instance.collection('todos').get();
    for (var item in snapshot.docs) {
      var todo = Todo(
        id: item['id'],
        title: item['title'],
        dayTime: DateTime.parse(item['dayTime']),
        category: TodoCategory.values.firstWhere((e) => e.toString() == item['category']),
        isCompleted: item['isCompleted'],
      );
      todos.add(todo);
    }
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

  Future<void> updateTodo(Todo todo) async {
    final snapshot = await FirebaseFirestore.instance.collection('todos').get();
    for (var doc in snapshot.docs) {
      if (todo.id == doc['id']) {
        await doc.reference.update(
          {
            'isCompleted': todo.isCompleted,
          },
        );
      }
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    final snapshot = await FirebaseFirestore.instance.collection('todos').get();
    for (var doc in snapshot.docs) {
      if (todo.id == doc['id']) {
        await doc.reference.delete();
      }
    }
  }
}
