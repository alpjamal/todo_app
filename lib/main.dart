import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'utils/constants.dart';
import 'data/cubits/color_cubit/color_cubit.dart';
import 'data/blocs/todos/todos_bloc.dart';
import 'data/cubits/panel/panel_cubit.dart';
import 'data/cubits/navbar/navbar_cubit.dart';
import 'data/cubits/prefs/prefs_cubit.dart';
import 'data/models/todo/todo.dart';
import 'data/models/todo_category/todo_category.dart';

part 'utils/theme.dart';
part 'screens/home_screen/app_bar.dart';
part 'screens/home_screen/add_todo_panel.dart';
part 'screens/onboarding_screen.dart';
part 'screens/home_screen/home_screen.dart';
part 'screens/home_screen/todos_list.dart';
part 'widgets/gradient_btn.dart';
part 'widgets/floating_btn.dart';
part 'widgets/todo_card.dart';
part 'widgets/category.dart';
part 'widgets/category_btn.dart';
part 'widgets/todo_alert.dart';

late bool _isInitial;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Hive adapters
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(TodoCategoryAdapter());

  Box prefs = await Hive.openBox<bool>(TodoPrefs.prefs);
  _isInitial = prefs.get(TodoPrefs.isInitial) ?? true;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrefsCubit()),
        BlocProvider(create: (_) => NavbarCubit()),
        BlocProvider(create: (_) => TodosBloc()..add(LoadTodos())),
        BlocProvider(create: (_) => TodoPanelCubit()),
        BlocProvider(create: (_) => ColorCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ToDoTheme().theme,
      home: _isInitial ? OnboardingScreen() : HomeScreen(),
    );
  }
}
