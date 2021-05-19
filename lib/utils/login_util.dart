import 'dart:convert' as convert;

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/config/common.dart';
import 'package:flutter_wanandroid/entity/userinfo_entity.dart';
import 'package:flutter_wanandroid/network/entity_factory.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/router/routers.dart';

class LoginUtil {
  static void saveUserInfo(UserInfo userInfo) {
    SpUtil.putString(Constant.userInfo, convert.jsonEncode(userInfo));
  }

  static UserInfo getUserInfo() {
    String info = SpUtil.getString(Constant.userInfo);
    if (info.isEmpty) return null;
    UserInfo userInfo = EntityFactory.generateOBJ<UserInfo>(
        convert.jsonDecode(SpUtil.getString(Constant.userInfo)));
    return userInfo;
  }

  static bool isLogin() {
    return SpUtil.getString(Constant.userInfo).isNotEmpty;
  }

  static checkLogin(BuildContext context, void then()) {
    if (isLogin()) {
      then();
    } else {
      NavigatorUtils.push(context, Routes.loginPage);
    }
  }
}
