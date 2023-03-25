import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/tasks/tasks_cubit.dart';

import '/data/navbar/navbar_cubit.dart';
import '/data/prefs/prefs_cubit.dart';
import '/utils/constants.dart';

part 'screens/onboarding_screen.dart';
part 'screens/home_screen.dart';
part 'utils/theme.dart';
part 'widgets/gradient_btn.dart';
part 'widgets/floating_btn.dart';
part 'widgets/task_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var prefs = await SharedPreferences.getInstance();
  bool isInitial = prefs.getBool(TodoPrefs.isInitial) ?? true;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrefsCubit()),
        BlocProvider(create: (_) => NavbarCubit()),
        BlocProvider(create: (_) => TasksCubit()..loadTasks()),
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
