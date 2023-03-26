part of '/main.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final color = BlocProvider.of<ColorCubit>(context).getColor(todo.category);
    final bellColor = BlocProvider.of<ColorCubit>(context).getBellColor(todo.dayTime);

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: TodoRadius.todoCard,
            boxShadow: [TodoShadow.todoCard],
          ),
          child: ClipRRect(
            borderRadius: TodoRadius.todoCard,
            child: Row(
              children: [
                Container(height: double.infinity, width: 4, color: color),
                SizedBox(width: 15),
                IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    context.read<TodosBloc>().add(TodoDone(todo: todo.copyWith(isCompleted: true)));
                  },
                  icon: todo.isCompleted
                      ? Icon(Icons.check_circle_rounded, color: Colors.green)
                      : Icon(Icons.circle_outlined, color: Colors.grey),
                ),
                SizedBox(width: 10),
                Text(DateFormat('MMM dd HH:mm').format(todo.dayTime), style: TodoStyle.cardTime),
                SizedBox(width: 10),
                Text(todo.title, style: TodoStyle.taskCard),
                Spacer(),
                Icon(Icons.notifications, color: bellColor),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
