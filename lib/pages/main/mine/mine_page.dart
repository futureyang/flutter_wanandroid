import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {

  const MinePage({Key key}) : super(key: key);


  @override
  createState() => new _MinePageState();
}

class _MinePageState extends State<MinePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text('MinePage'),
        ),
        body: new Text('MinePage')
    );
  }
}