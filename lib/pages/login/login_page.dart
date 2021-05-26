import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/userinfo_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/router/routers.dart';
import 'package:flutter_wanandroid/utils/login_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';

import 'my_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _controllerAccount = TextEditingController();
  var _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Container(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 80 + context.statusBarHeight),
            Icon(
              Icons.android_rounded,
              size: 110,
              color: context.textColor,
            ),
            SizedBox(height: 50),
            MyInputField(
              textEditingController: _controllerAccount,
              isShowRight: false,
              isPassword: false,
              iconData: Icons.account_circle_rounded,
              hintText: '请输入账号',
            ),
            SizedBox(height: 30),
            MyInputField(
              textEditingController: _controllerPassword,
              iconData: Icons.lock,
              hintText: '请输入密码',
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.only(top: 15, right: 60),
                      child: Text("去注册",
                          style: TextStyle(
                              color: context.textColor, fontSize: 13))),
                  onTap: () {
                    NavigatorUtils.push(context, Routes.registeredPage);
                  },
                )),
            _LoginBtn(context)
          ],
        )),
      ),
    );
  }

  //登录按钮
  _LoginBtn(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: context.isDark
                ? MyColor.bgColorThirdNight
                : MyColor.bgColorThirdLight,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(offset: Offset(0, 1), color: context.hintColor)
            ]),
        padding: EdgeInsets.all(10.0),
        child: Text(
          "登录",
          style: TextStyle(fontSize: 15, color: context.textColor),
        ),
      ),
      onTap: () {
        _login();
      },
    );
  }

  _login() {
    String account = _controllerAccount.text;
    String password = _controllerPassword.text;
    if (account.isEmpty) {
      return Toast.show('账号不能为空');
    } else if (password.isEmpty) {
      return Toast.show('密码不能为空');
    }
    var loginMap = {
      "username": account,
      "password": password,
    };
    DioManager.post<UserInfo>(API.LOGIN, loginMap, (data) {
      LoginUtil.saveUserInfo(data);
      NavigatorUtils.push(context, Routes.main, clearStack: true);
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }
}
