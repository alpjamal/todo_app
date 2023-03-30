part of '../../main.dart';

class TodosList extends StatelessWidget {
  const TodosList(this.state, {super.key});
  final TodosLoaded state;

  @override
  Widget build(BuildContext context) {
    Map days = BlocProvider.of<TodosBloc>(context).separate(state.todos);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
      itemCount: days.length,
      itemBuilder: (context, mainIndex) {
        String title = days.keys.toList()[mainIndex];
        List<Todo> adf = days[title]!;
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
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              backgroundColor: TodoColor.meeting.withOpacity(0.3),
            ),
            onPressed: () => ctx.read<TodosBloc>().add(DeleteTodo(todo: todo)),
            child: Icon(Icons.delete_outline_sharp, color: TodoColor.meeting),
          ),
          Spacer(),
        ],
      ),
      child: TodoCard(todo: todo),
    );
  }
}
