import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../utils/constants.dart';

part 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  PrefsCubit() : super(PrefsInitial());
  
  start() async {
    Box<bool> prefs = await Hive.openBox<bool>(TodoPrefs.prefs);
    prefs.put(TodoPrefs.isInitial, false);
  }
}
