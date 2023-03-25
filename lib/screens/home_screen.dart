part of '/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var navBar = BlocProvider.of<NavbarCubit>(context, listen: true);
    return Scaffold(
      appBar: _appBar(context),
      body: navBar.isHome
          ? BlocBuilder<TasksCubit, TasksState>(
              builder: (ctx, state) {
                if (state is TasksLoaded) {
                  return state.tasks.isEmpty
                      ? Container(
                          padding: EdgeInsets.fromLTRB(0, 200, 0, 240),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(TodoImage.empty, cacheHeight: 200),
                              Text('No tasks', style: TodoStyle.entry),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                          itemCount: state.tasks.length,
                          itemBuilder: (ctx, index) {
                            var task = state.tasks[index];
                            return TaskCard(title: task.title, time: task.time);
                          },
                        );
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          : Center(child: Text('Task')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navBar.currIndex,
        selectedLabelStyle: TodoStyle.label,
        unselectedLabelStyle: TodoStyle.label,
        onTap: (value) => navBar.changeIndex(value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.window_sharp), label: 'Task'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GradientFloatingBtn(
        onPressed: () {},
      ),
    );
  }

  _appBar(ctx) {
    int tasksLength = BlocProvider.of<TasksCubit>(ctx).tasksLength;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      flexibleSpace: Image.asset(TodoImage.appBar, fit: BoxFit.cover),
      // toolbarHeight: 240,
      leadingWidth: 0,
      title: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello Brenda!\nToday you have $tasksLength tasks', style: TodoStyle.appBar),
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
        ),
      ),
    );
  }
}
