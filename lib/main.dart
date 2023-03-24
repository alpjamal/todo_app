import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/cubit/prefs_cubit.dart';
import 'package:todo_app/utils/constants.dart';

part 'screens/onboarding_screen.dart';
part 'screens/home_screen.dart';
part 'utils/theme.dart';
part 'widgets/gradient_btn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var prefs = await SharedPreferences.getInstance();
  bool isInitial = prefs.getBool(TodoPrefs.isInitial) ?? true;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrefsCubit()),
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
