import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetNoFound extends StatelessWidget {
  const WidgetNoFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
      ),
      body: Center(
        child: Text('404'),
      ),
    );
  }
}
