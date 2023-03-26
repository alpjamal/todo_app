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
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello User!\nToday you have ${todos.length} tasks', style: TodoStyle.appBar),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                )
              ],
            ),
            SizedBox(height: 10),
            if (alertTodo != null) TodoAlert(todo: alertTodo),
          ],
        ),
      ),
    );
  }
}
