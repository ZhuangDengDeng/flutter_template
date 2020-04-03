import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'application.dart';

class NavigatorUtils {
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.cupertino);
  }

  //带返回结果push
  static Future<T> pushResult<T>(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) async {
    FocusScope.of(context).unfocus();
    final T result = await Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.cupertino);
    return result;
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams<T>(BuildContext context, T result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }
}
