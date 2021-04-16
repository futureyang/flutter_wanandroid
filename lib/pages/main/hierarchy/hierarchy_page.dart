import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/provider/theme_provider.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

import 'package:provider/provider.dart';

class HierarchyPage extends StatefulWidget {

  const HierarchyPage({Key key}) : super(key: key);

  @override
  createState() => new _HierarchyPageState();
}

class _HierarchyPageState extends State<HierarchyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: new AppBar(
          title: new Text('HierarchyPage'),
        ),
        body: ElevatedButton(
          onPressed: () {
            context.read<ThemeProvider>().setTheme(ThemeMode.light);
            setState(() {});
          },
          child: new Text('HierarchyPage'),
        ));
  }
}