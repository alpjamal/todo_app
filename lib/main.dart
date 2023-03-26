import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'utils/constants.dart';
import 'data/color_cubit/color_cubit.dart';
import 'data/todo_category/category_bloc.dart';
import 'data/todos/todos_bloc.dart';
import 'data/panel/panel_cubit.dart';
import 'data/navbar/navbar_cubit.dart';
import 'data/prefs/prefs_cubit.dart';
import 'data/models/todo.dart';
import 'data/models/todo_category.dart';

part 'utils/theme.dart';
part 'screens/home_screen/app_bar.dart';
part 'screens/onboarding_screen.dart';
part 'screens/home_screen/home_screen.dart';
part 'widgets/gradient_btn.dart';
part 'widgets/floating_btn.dart';
part 'widgets/todo_card.dart';
part 'widgets/category.dart';
part 'widgets/category_btn.dart';
part 'widgets/todo_alert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var prefs = await SharedPreferences.getInstance();
  bool isInitial = prefs.getBool(TodoPrefs.isInitial) ?? true;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrefsCubit()),
        BlocProvider(create: (_) => NavbarCubit()),
        BlocProvider(
            create: (_) => TodosBloc()
              ..add(LoadTodos(
                todos: [
                  // Todo(id: '', title: 'Todo1', dayTime: 'day time', category: TodoCategory.meeting),
                  // Todo(id: '', title: 'Todo2', dayTime: 'day time', category: TodoCategory.meeting),
                ],
              ))),
        BlocProvider(create: (_) => TodoPanelCubit()),
        BlocProvider(create: (ctx) => CategoryBloc(todosBloc: BlocProvider.of<TodosBloc>(ctx))),
        BlocProvider(create: (_) => ColorCubit()),
      ],
      child: MyApp(isInitial),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp(this.isInitial, {super.key});
  final bool isInitial;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ToDoTheme().theme,
      home: isInitial ? OnboardingScreen() : HomeScreen(),
    );
  }
}
