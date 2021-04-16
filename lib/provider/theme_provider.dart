import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/common.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/res/styles.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {

  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode(){
    final String theme = SpUtil.getString(Constant.theme);
    switch(theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      backgroundColor: isDarkMode ? MyColor.bgColorPrimaryNight : MyColor.bgColorPrimaryLight,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? MyColor.colorPrimaryNight : MyColor.colorPrimaryLight,
      accentColor: isDarkMode ? MyColor.colorAccentNight : MyColor.colorAccentLight,
      hintColor : isDarkMode ? MyColor.textColorThirdNight : MyColor.textColorThirdLight,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? MyColor.colorPrimaryNight : MyColor.colorPrimaryLight,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? MyColor.bgColorSecondaryNight : MyColor.bgColorSecondaryLight,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? MyColor.dark_material_bg : MyColor.bgColorPrimaryLight,
      textTheme: TextTheme(
        // TextField输入文字颜色
        subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        bodyText1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        bodyText2: isDarkMode ? TextStyles.textSecondaryDark : TextStyles.textSecondary,
        subtitle2: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? MyColor.textColorPrimaryNight : MyColor.bgColorPrimaryLight,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? MyColor.bgColorThirdNight : MyColor.bgColorThirdLight,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //         backgroundColor: isDarkMode ? MaterialStateProperty.all(MyColor.bgColorThirdNight)
      //             : MaterialStateProperty.all(MyColor.bgColorThirdLight),
      //         foregroundColor: isDarkMode ? MaterialStateProperty.all(MyColor.textColorPrimaryNight)
      //           : MaterialStateProperty.all(MyColor.textColorPrimaryLight),
      //         overlayColor: isDarkMode ? MaterialStateProperty.all(MyColor.bgColorThirdNight)
      //             : MaterialStateProperty.all(MyColor.bgColorThirdLight),
      //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(5)))),
      //     )
      // ),
    );
  }

}