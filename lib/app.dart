import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/i10n/localization_intl.dart';
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
      onGenerateTitle: (context) {
        return AppLocalizations.of(context).title;
      },
      home: HomePage().buildPage(null),
      onGenerateRoute: Application.router.generator,
      localizationsDelegates: [
        AppLocalizationsDelegate(), // 我们定义的代理
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        // 支持的语言类型
        const Locale('en', 'US'), // English
        const Locale('zh', 'CN'),
      ],
    ),
  );
}
