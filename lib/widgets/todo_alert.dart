part of '/main.dart';

class TodoAlert extends StatelessWidget {
  const TodoAlert({required this.todo, super.key});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: TodoRadius.todoCard,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Todays Reminder', style: TodoStyle.alertTitle),
                  Text(todo.title, style: TodoStyle.label),
                  Text(DateFormat.jm().format(todo.dayTime), style: TodoStyle.label),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 60),
                child: SvgPicture.asset(TodoIcon.bell, height: 70),
              ),
            ],
          ),
        ),
        Positioned(top: 10, right: 10, child: Icon(Icons.close)),
      ],
    );
  }
}
