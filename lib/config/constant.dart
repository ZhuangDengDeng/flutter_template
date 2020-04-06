class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction =
      const bool.fromEnvironment("dart.vm.product");

  //测试环境
  static bool isTest = false;

  //request
  static String baseUrl = 'http://localhost:3000';

  static const String loginToken = 'daloginTokenta';
  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
}
