part of '../../main.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = BlocProvider.of<TodosBloc>(context).todos;
    Todo? alertTodo = BlocProvider.of<TodosBloc>(context).alertTodo;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      flexibleSpace: Image.asset(TodoImage.appBar, fit: BoxFit.cover),
      toolbarHeight: alertTodo == null ? TodoSize.appBarNoAlert : TodoSize.appBarAlert,
      leadingWidth: 0,
      title: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have ${todos.length} tasks', style: TodoStyle.appBar),
            SizedBox(width: double.infinity),
            if (alertTodo != null) ...[
              SizedBox(height: 10),
              TodoAlert(todo: alertTodo),
            ],
          ],
        ),
      ),
    );
  }
}
