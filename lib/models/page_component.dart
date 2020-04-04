import 'package:fish_redux/fish_redux.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class PageComponent {
  const PageComponent(
      {@required this.pageName, @required this.page, this.handler});

  final String pageName;
  final Page page;
  final HandlerFunc handler;
}
