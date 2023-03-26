import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app/utils/constants.dart';

part 'panel_state.dart';

class TodoPanelCubit extends Cubit<TodoPanelState> {
  TodoPanelCubit() : super(TodoPanelInitial());

  double _fabBottomPadding = TodoSize.fabBottomPadding;

  getFabBottomPadding(double value) {
    return _fabBottomPadding + value * 0.735;
  }

  final double _panelMaxHeight = TodoSize.panelMaxHeight;
  get panelMaxHeight => _panelMaxHeight;

  final PanelController _panelController = PanelController();
  get panelController => _panelController;

  onPanelSlide(position) {
    _fabBottomPadding = position * TodoSize.panelMaxHeight + TodoSize.fabBottomPadding;
    emit(TodoPanelChange());
  }

  openPanel() {
    _panelController.open();
    emit(TodoPanelChange());
  }

  closePanel() {
    _panelController.close();
    emit(TodoPanelChange());
  }
}
