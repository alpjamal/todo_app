part of '/../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var navBar = BlocProvider.of<NavbarCubit>(context, listen: true);
    var panel = BlocProvider.of<TodoPanelCubit>(context, listen: true);
    Todo? alertTodo = BlocProvider.of<TodosBloc>(context).alertTodo;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(alertTodo == null ? TodoSize.appBarNoAlert : TodoSize.appBarAlert - 25),
        child: UserAppBar(),
      ),
      body: BlocConsumer<TodosBloc, TodosState>(
        listener: (ctx, state) {
          if (state is TodosLoaded) {
            panel.closePanel();
          }
        },
        builder: (context, state) {
          return SlidingUpPanel(
            controller: panel.panelController,
            maxHeight: panel.panelMaxHeight,
            minHeight: 0,
            onPanelSlide: (position) => panel.onPanelSlide(position),
            borderRadius: TodoRadius.elliptical,
            panelBuilder: (sc) => AddTodoPanel(),
            body: state is TodosLoading
                ? Center(child: CircularProgressIndicator())
                : navBar.isHome
                    ? BlocBuilder<TodosBloc, TodosState>(
                        builder: (ctx, state) {
                          if (state is TodosLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is TodosLoaded) {
                            return state.todos.isEmpty ? _noTodos() : TodosList(state.todos);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                    : _categories(),
          );
        },
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BottomNavigationBar(
            currentIndex: navBar.currIndex,
            selectedLabelStyle: TodoStyle.label,
            unselectedLabelStyle: TodoStyle.label,
            onTap: (value) {
              panel.closePanel();
              navBar.changeIndex(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.window_sharp), label: 'Tasks'),
            ],
          ),
          Positioned(
            bottom: panel.getFabBottomPadding(MediaQuery.of(context).viewInsets.bottom),
            child: GradientFloatingBtn(
              onPressed: () => panel.openPanel(),
            ),
          ),
        ],
      ),
    );
  }

  _categories() {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (ctx, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: TodoCategory.values.length - 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (ctx, index) {
              return TodoCategoryCard(index, state);
            },
          ),
        );
      },
    );
  }

  _noTodos() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(TodoIcon.empty, height: 200),
        SizedBox(height: 50),
        Text('No tasks', style: TodoStyle.entry),
        SizedBox(height: 200),
      ],
    );
  }
}
