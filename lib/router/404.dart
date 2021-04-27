import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {

  const NotFoundPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("widget not found"),
        ),
        body: Container(child: Text("widget not found")));
  }
}
