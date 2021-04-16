import 'dart:async';
import 'dart:convert' as convert;

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/config/common.dart';
import 'package:flutter_wanandroid/entity/userinfo_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/network/entity_factory.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';

import 'my_input_field.dart';

class RegisteredPage extends StatefulWidget {
  const RegisteredPage({Key key}) : super(key: key);

  @override
  createState() => _RegisteredPageState();
}

class _RegisteredPageState extends State<RegisteredPage> {
  var _controllerAccount = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerPasswordConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: new AppBar(),
      body: Container(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 30),
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
            SizedBox(height: 30),
            MyInputField(
              textEditingController: _controllerPasswordConfirm,
              iconData: Icons.lock,
              hintText: '确认密码',
            ),
            _registeredBtn(context)
          ],
        )),
      ),
    );
  }

  //登录按钮
  _registeredBtn(BuildContext context) {
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
          "注册",
          style: TextStyle(fontSize: 15),
        ),
      ),
      onTap: () {
        _registered();
      },
    );
  }

  _registered() {
    String account = _controllerAccount.text.trim();
    String password = _controllerPassword.text.trim();
    String passwordConfirm = _controllerPasswordConfirm.text.trim();

    if (account.isEmpty) {
      return Toast.show('账号不能为空');
    } else if (account.length < 3) {
      return Toast.show('账号不能少于3位');
    } else if (password.isEmpty) {
      return Toast.show('密码不能为空');
    } else if (password.length < 6) {
      return Toast.show('密码不能少于6位');
    } else if (password != passwordConfirm) {
      return Toast.show('两次输入的密码不一致');
    }
    var registeredMap = {
      "username": account,
      "password": password,
      "repassword": passwordConfirm
    };
    DioManager.post<UserInfo>(API.REGISTER, registeredMap, (data) {
      SpUtil.putString(Constant.userInfo, convert.jsonEncode(data));
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }
}
