import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {

  const NavigationPage({Key key}) : super(key: key);

  @override
  createState() => new _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>{
   Widget build(BuildContext context) {
     return CustomScrollView(
       slivers: <Widget>[
         SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
         SliverFixedExtentList(
           itemExtent: 48.0,
           delegate: SliverChildBuilderDelegate(
                 (BuildContext context, int index) => ListTile(title: Text('Item $index')),
             childCount: 30,
           ),
         ),
       ],
     );
   }
}