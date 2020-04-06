import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/page/home_page/page.dart';
import 'package:flutter_template/router/application.dart';
import 'package:flutter_template/router/routes.dart';
import 'package:oktoast/oktoast.dart';

Widget createApp() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  return OKToast(
    child: MaterialApp(
      home: HomePage().buildPage(null),
      onGenerateRoute: Application.router.generator,
    ),
  );
}
