import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/pages/login/login_page.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/res/strings.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/double_tap_back_exit_app.dart';

import 'package:provider/provider.dart';
import 'login/registered_page.dart';
import 'main/hierarchy/hierarchy_page.dart';
import 'main/home/home_page.dart';
import 'main/navigation/navigation_page.dart';
import 'main/mine/mine_page.dart';
import 'main_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  final appBarTitles = ['主页', '购买商标', '在线咨询', '我的'];
  List<Widget> _pageList;

  MainProvider provider = MainProvider();
  final PageController _pageController = PageController();

  void initData() {
    _pageList = [
      const HomePage(),
      const HierarchyPage(),
      const RegisteredPage(),
      const LoginPage()
    ];
  }

  @override
  void initState() {
    super.initState();
    //显示状态栏
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
            bottomNavigationBar: Consumer<MainProvider>(
              builder: (_, provider, __) {
                return _buildBottomNavigationBar(context.isDark);
              },
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
              controller: _pageController,
              onPageChanged: (int index) => provider.value = index,
              children: _pageList,
            )),
      ),
    );
  }

  _buildBottomNavigationBar(bool isDark) {
    return new BottomNavigationBar(
      backgroundColor: context.backgroundColor,
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: isDark
                    ? MyColor.textColorThirdNight
                    : MyColor.textColorThirdLight),
            activeIcon: Icon(Icons.home,
                size: 26.0,
                color: isDark
                    ? MyColor.textColorPrimaryNight
                    : MyColor.textColorPrimaryLight),
            label: MyString.home),
        new BottomNavigationBarItem(
            icon: Icon(Icons.equalizer,
                color: isDark
                    ? MyColor.textColorThirdNight
                    : MyColor.textColorThirdLight),
            activeIcon: Icon(Icons.equalizer,
                size: 26.0,
                color: isDark
                    ? MyColor.textColorPrimaryNight
                    : MyColor.textColorPrimaryLight),
            label: MyString.hierarchy),
        new BottomNavigationBarItem(
            icon: Icon(Icons.navigation_rounded,
                color: isDark
                    ? MyColor.textColorThirdNight
                    : MyColor.textColorThirdLight),
            activeIcon: Icon(Icons.navigation_rounded,
                size: 26.0,
                color: isDark
                    ? MyColor.textColorPrimaryNight
                    : MyColor.textColorPrimaryLight),
            label: MyString.navigation),
        new BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: isDark
                    ? MyColor.textColorThirdNight
                    : MyColor.textColorThirdLight),
            activeIcon: Icon(Icons.person,
                size: 26.0,
                color: isDark
                    ? MyColor.textColorPrimaryNight
                    : MyColor.textColorPrimaryLight),
            label: MyString.mine),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: provider.value,
      selectedItemColor: isDark
          ? MyColor.textColorPrimaryNight
          : MyColor.textColorPrimaryLight,
      unselectedItemColor:
          isDark ? MyColor.textColorThirdNight : MyColor.textColorThirdLight,
      onTap: (index) {
        _pageController.jumpToPage(index);
      },
    );
  }
}
