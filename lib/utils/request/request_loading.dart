import 'package:flutter_template/utils/toast.dart';

class Loading {
  static void before(text) {
    // 请求前显示弹窗
    Toast.show(text);
  }

  static void complete() {
    // 完成后关闭loading窗口
    Toast.cancelToast();
  }
}
