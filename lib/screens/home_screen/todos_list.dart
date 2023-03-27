part of '../../main.dart';

class TodosList extends StatelessWidget {
  const TodosList(this.state, {super.key});
  final TodosLoaded state;

  @override
  Widget build(BuildContext context) {
    final todos = state.todos;
    Map map = _separate(todos);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
      itemCount: map.length,
      itemBuilder: (context, mainIndex) {
        String title = map.keys.toList()[mainIndex];
        List<Todo> adf = map[title]!;
        return Column(
          children: [
            SizedBox(width: double.infinity, child: Text(title, style: TodoStyle.btn)),
            ...List.generate(adf.length, (index) => _todoCard(adf[index], context)),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  _todoCard(Todo todo, BuildContext ctx) {
    return Slidable(
      key: ValueKey(todo.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: Platform.isIOS ? 0.27 : 0.30,
        children: [
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: TodoColor.purple.withOpacity(0.4),
            elevation: 0,
            mini: true,
            child: Icon(Icons.edit_outlined, color: TodoColor.purple),
          ),
          FloatingActionButton(
            onPressed: () => ctx.read<TodosBloc>().add(DeleteTodo(todo: todo)),
            elevation: 0,
            backgroundColor: TodoColor.meeting.withOpacity(0.4),
            mini: true,
            child: Icon(Icons.delete_outline_sharp, color: TodoColor.meeting),
          ),
        ],
      ),
      child: TodoCard(todo: todo),
    );
  }

  _separate(todos) {
    Map<String, List<Todo>> map = {};
    for (var i = 0; i < todos.length; i++) {
      String day = DateFormat('dd MM yyy').format(todos[i].dayTime);
      Todo todo = todos[i];
      map[day] == null ? map[day] = [] : null;
      map[day]!.add(todo);
    }
    return map;
  }
}
