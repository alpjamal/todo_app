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
      body: BlocListener<TodosBloc, TodosState>(
        listener: (ctx, state) {
          if (state is TodosLoaded) {
            panel.closePanel();
          }
        },
        child: SlidingUpPanel(
          controller: panel.panelController,
          maxHeight: panel.panelMaxHeight,
          minHeight: 0,
          onPanelSlide: (position) => panel.onPanelSlide(position),
          borderRadius: TodoRadius.elliptical,
          panelBuilder: (sc) => AddTodoPanel(),
          body: navBar.isHome
              ? BlocBuilder<TodosBloc, TodosState>(
                  builder: (ctx, state) {
                    if (state is TodosLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TodosLoaded) {
                      return state.todos.isEmpty ? _noTodos() : _todos(context, state);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : _categories(),
        ),
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
              BottomNavigationBarItem(icon: Icon(Icons.window_sharp), label: 'Task'),
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

  _todos(BuildContext ctx, TodosLoaded state) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
      itemCount: state.todos.length,
      itemBuilder: (ctx, index) {
        var todo = state.todos[index];
        return Slidable(
          key: ValueKey(todo.id),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            extentRatio: Platform.isIOS ?  0.27 : 0.30,
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
      },
    );
  }

  _noTodos() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(TodoImage.empty, cacheHeight: 200),
        SizedBox(height: 50),
        Text('No tasks', style: TodoStyle.entry),
        SizedBox(height: 200),
      ],
    );
  }
}
