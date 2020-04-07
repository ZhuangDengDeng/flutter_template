import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/models/page/page_component.dart';
import 'package:flutter_template/page/404.dart';
import 'package:flutter_template/page/home_page/page.dart';
import 'package:flutter_template/router/router_handler.dart';
import 'package:flutter_template/global_store/store.dart';
import 'package:flutter_template/global_store/state.dart';

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
        pageName: Routes.home, page: HomePage(), handler: homePageHandler));

    ///添加公共的方法
    listRoutes.forEach((PageComponent route) {
      /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
      /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
      if (route.page.isTypeof<GlobalBaseState>()) {
        /// 建立 AppStore 驱动 PageStore 的单向数据连接
        /// 1. 参数1 AppStore
        /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
        route.page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pagestate, GlobalState appState) {
          return pagestate;
        });
      }

      router.define(route.pageName,
          handler: Handler(
              //如果路由含有自定义handler,则使用路由自带handler
              //否则配置默认渲染方式
              handlerFunc: route.handler ??
                  (BuildContext context, Map<String, List<String>> params) =>
                      route.page.buildPage(null)));
    });
  }
}
