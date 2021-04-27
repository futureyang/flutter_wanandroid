import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/router/routers.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'pages/splash_page.dart';
import 'provider/theme_provider.dart';
import 'utils/device_utils.dart';
import 'utils/theme_utils.dart';

void main() async {
  runApp(MyApp());
  //隐藏状态栏
  SystemChrome.setEnabledSystemUIOverlays([]);
  Routes.initRoutes();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Widget app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, ThemeProvider provider, __) {
          return _buildMaterialApp(provider);
        },
      ),
    );
    /// Toast 配置
    return OKToast(
        child: app,
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom
    );
  }

Widget _buildMaterialApp(ThemeProvider provider){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '玩Android',
    themeMode: provider.getThemeMode(),
    theme: provider.getTheme(),
    darkTheme: provider.getTheme(isDarkMode: true),
    home: SplashPage(),
    builder: (BuildContext context, Widget child) {
      /// 仅针对安卓
      if (Device.isAndroid) {
        /// 切换深色模式会触发此方法，这里设置导航栏颜色
        ThemeUtils.setSystemNavigationBar(provider.getThemeMode());
      }
      /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child,
      );
    },
    // onGenerateRoute: Application.router.generator,
  );
}
}
