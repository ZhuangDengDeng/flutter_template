import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { action }

class GlobalActionCreator {
  static Action action() {
    return Action(GlobalAction.action);
  }
}
