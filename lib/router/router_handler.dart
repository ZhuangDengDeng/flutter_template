import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/page/home.dart';

//homePage handler
HandlerFunc homePageHandler =
    (BuildContext context, Map<String, List<String>> params) {
  return Home();
};
