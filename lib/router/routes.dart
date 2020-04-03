import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/models/page_component.dart';
import 'package:flutter_template/page/404.dart';
import 'package:flutter_template/page/home.dart';
import 'package:flutter_template/router/router_handler.dart';

class Routes {
  static String home = '/home';

  //路由页面数组
  static List<PageComponent> listRoutes = [];

  static void configureRoutes(Router router) {
    // 路由跳转错误页面
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return WidgetNoFound();
    });

    // 将路由添加到路由数组中,其中pageName与page为必填
    listRoutes.add(PageComponent(
        pageName: Routes.home, page: Home(), handler: homePageHandler));

    ///添加公共的方法
    listRoutes.forEach((PageComponent route) {
      router.define(route.pageName,
          handler: Handler(
              //如果路由含有自定义handler,则使用路由自带handler
              //否则配置默认渲染方式
              handlerFunc: route.handler ??
                  (BuildContext context, Map<String, List<String>> params) =>
                      route.page));
    });
  }
}
