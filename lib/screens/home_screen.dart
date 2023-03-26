part of '/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController controller;
  Todo? _todo;
  String? _title;
  String? _dayTime;
  TodoCategory? _category;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var navBar = BlocProvider.of<NavbarCubit>(context, listen: true);
    var panel = BlocProvider.of<TodoPanelCubit>(context, listen: true);

    return Scaffold(
      appBar: _appBar(context),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (ctx, state) {
          if (state is TodosLoaded) {
            panel.closePanel();
            controller.clear();
          }
        },
        child: SlidingUpPanel(
          controller: panel.panelController,
          maxHeight: panel.panelMaxHeight,
          minHeight: 0,
          onPanelSlide: (position) => panel.onPanelSlide(position),
          borderRadius: TodoRadius.elliptical,
          panelBuilder: (sc) => _addTodoPanel(context, panel),
          onPanelClosed: () {
            _todo = null;
            _title = null;
            _dayTime = null;
            _category = null;
          },
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
          return TodoCategoryCard(index: index);
        },
      ),
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
            extentRatio: 0.27,
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

  _addTodoPanel(BuildContext ctx, TodoPanelCubit panel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          Text('Add new taks', style: TodoStyle.panelTitle),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            onChanged: (value) => _title = value,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: TodoCategory.values.length - 1,
              itemBuilder: (_, index) {
                final category = TodoCategory.values[index];
                return SelectCategoryBtn(
                  category: category,
                  onTap: () => _category = TodoCategory.values[index],
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Choose date  '),
              IconButton(
                onPressed: () async {
                  DateTime? date = await _pickDate(ctx);
                  if (date == null) return;
                  DateTime day = DateTime(date.year, date.month, date.day);

                  // ignore: use_build_context_synchronously
                  TimeOfDay? time = await _pickTime(ctx);
                  if (time == null) return;
                  String hour = time.hour.toString().padLeft(2, '0');
                  String minute = time.minute.toString().padLeft(2, '0');

                  String dateTime = DateFormat.MMMMd().format(day);
                  _dayTime = '$dateTime $hour:$minute';
                  setState(() {});
                },
                icon: Icon(Icons.arrow_drop_down_sharp),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(_dayTime ?? '', style: TodoStyle.btn.copyWith(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 20),
          GradientButton(
            title: 'Add Task',
            onPressed: () {
              if (_title == null || _dayTime == null || _category == null) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please, enter right info!')));
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _todo = Todo(
                  id: DateTime.now().toString(),
                  title: _title!,
                  dayTime: _dayTime!,
                  category: _category!,
                );
                ctx.read<TodosBloc>().add(AddTodo(todo: _todo!));
                ctx.read<ColorCubit>().select(null);
                _todo = null;
              }
            },
          ),
        ],
      ),
    );
  }

  _pickDate(ctx) {
    return showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
  }

  _pickTime(ctx) => showTimePicker(context: ctx, initialTime: TimeOfDay.now());

  _appBar(ctx) {
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
                      Text('Hello Brenda!\nToday you have ${state.todos.length} tasks', style: TodoStyle.appBar),
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
