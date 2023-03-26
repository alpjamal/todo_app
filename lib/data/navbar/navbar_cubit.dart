import 'package:flutter_bloc/flutter_bloc.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());

  int _currIndex = 0;

  bool get isHome => _currIndex == 0;

  int get currIndex => _currIndex;

  changeIndex(int value) {
    _currIndex = value;
    emit(NavbarChanged());
  }
}
