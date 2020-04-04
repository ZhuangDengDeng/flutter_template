import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/page/home_page/page.dart';
import 'package:flutter_template/router/application.dart';
import 'package:flutter_template/router/routes.dart';

Widget createApp() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  return MaterialApp(
    home: HomePage().buildPage(null),
    onGenerateRoute: Application.router.generator,
  );
}
