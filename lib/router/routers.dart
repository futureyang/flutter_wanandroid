import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/detail/detail_page.dart';
import 'package:flutter_wanandroid/pages/login/login_page.dart';
import 'package:flutter_wanandroid/pages/login/registered_page.dart';
import 'package:flutter_wanandroid/pages/search/search_page.dart';
import 'package:flutter_wanandroid/router/404.dart';
import 'package:flutter_wanandroid/pages/main_page.dart';

class Routes {
  static String main = "/";

  static String loginPage = '/login/login';
  static String registeredPage = '/login/registered';
  static String searchPage = '/search';

  static String detailPage = '/detail';

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return const NotFoundPage();
    });

    router.define(main,
        handler: Handler(handlerFunc: (_, __) => const MainPage()));
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, __) => const LoginPage()));
    router.define(registeredPage,
        handler: Handler(handlerFunc: (_, __) => const RegisteredPage()));
    router.define(searchPage,
        handler: Handler(handlerFunc: (_, __) => const SearchPage()));
    router.define(detailPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first;
      final String url = params['url']?.first;
      return DetailPage(title: title, url: url);
    }));
  }
}
