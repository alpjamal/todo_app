part of '../../main.dart';

class AddTodoPanel extends StatefulWidget {
  const AddTodoPanel({super.key});

  @override
  State<AddTodoPanel> createState() => _AddTodoPanelState();
}

class _AddTodoPanelState extends State<AddTodoPanel> {
  late TextEditingController controller;
  Todo? _todo;
  String? _title;
  DateTime? _dayTime;
  TodoCategory? _category;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          Text('Add new taks', style: TodoStyle.panelTitle),
          SizedBox(height: 10),
          TextField(controller: controller, onChanged: (value) => _title = value),
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
                  DateTime? date = await _pickDate(context);
                  if (date == null) return;
                  // ignore: use_build_context_synchronously
                  TimeOfDay? time = await _pickTime(context);
                  if (time == null) return;
                  _dayTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                  setState(() {});
                },
                icon: Icon(Icons.arrow_drop_down_sharp),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              _dayTime != null ? DateFormat('MMM dd HH:mm').format(_dayTime!) : '',
              style: TodoStyle.btn.copyWith(fontWeight: FontWeight.bold),
            ),
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
                context.read<TodosBloc>().add(AddTodo(todo: _todo!));
                context.read<ColorCubit>().select(null);
                _clear();
              }
            },
          ),
        ],
      ),
    );
  }

  _clear() {
    _todo = null;
    controller.clear();
    _todo = null;
    _title = null;
    _dayTime = null;
    _category = null;
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
}
