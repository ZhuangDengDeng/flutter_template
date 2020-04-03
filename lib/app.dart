import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/page/home.dart';
import 'package:flutter_template/router/application.dart';
import 'package:flutter_template/router/routes.dart';

Widget createApp() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  return MaterialApp(
    home: Home(),
    onGenerateRoute: Application.router.generator,
  );
}
