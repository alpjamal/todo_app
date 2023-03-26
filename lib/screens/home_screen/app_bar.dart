part of '../../main.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      flexibleSpace: Image.asset(TodoImage.appBar, fit: BoxFit.cover),
      // toolbarHeight: 240,
      leadingWidth: 0,
      title: Padding(
        padding: EdgeInsets.all(20.0),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (state is TodosLoaded)
                      Text('Hello User!\nToday you have ${state.todos.length} tasks', style: TodoStyle.appBar),
                    if (state is TodosLoading) Text('Hello Brenda!\nToday you have 0  tasks', style: TodoStyle.appBar),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
