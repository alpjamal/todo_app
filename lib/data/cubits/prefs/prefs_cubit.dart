import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';



part 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  PrefsCubit() : super(PrefsInitial());
  start() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(TodoPrefs.isInitial, false);
  }
}
