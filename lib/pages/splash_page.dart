import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/pages/main/home/home_page.dart';
import 'package:flutter_wanandroid/pages/main_page.dart';
import 'package:flutter_wanandroid/pages/search/search_page.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    // 初始化变量
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.5, end: 1.0).animate(_controller);
    // 添加监听事件
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画完成了
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return MainPage();
        }), (route) {
          return route == null;
        });
      }
    });
    // 动画开始
    _controller.forward();
    inin();
  }

  inin() async {
    await DioManager.getInstance();
    await SpUtil.getInstance();
  }

  @override
  void dispose() {
    // 销毁控制器
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation,
        child: Container(
          color: context.backgroundColor,
          padding: EdgeInsets.all(140),
          child: Image.asset(
            "assets/images/logo.png",
            color: context.textColor,
          ),
        ));
  }
}
