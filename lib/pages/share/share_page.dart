import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/userinfo_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/res/strings.dart';
import 'package:flutter_wanandroid/utils/login_util.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

///我的分享
class SharePage extends StatefulWidget {
  const SharePage({Key key}) : super(key: key);

  @override
  createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextEditingController controllerTitle;

  TextEditingController controllerLink;

  String userName = '';

  @override
  void initState() {
    super.initState();
    controllerTitle = TextEditingController();
    controllerLink = TextEditingController();
    getUserName();
  }

  getUserName() {
    UserInfo userInfo = LoginUtil.getUserInfo();
    String name = userInfo.nickname;
    setState(() {
      userName = name.isEmpty ? userInfo.username : name;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerTitle.dispose();
    controllerLink.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: TitleBar('我的分享',
          isShowRight: true,
          rightWidget: GestureDetector(
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: titleWidget(MyString.submit)),
              onTap: () => submit())),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          SizedBox(height: 20),
          titleWidget(MyString.title),
          SizedBox(height: 15),
          titleField(),
          SizedBox(height: 30),
          titleWidget(MyString.link),
          SizedBox(height: 15),
          linkField(),
          SizedBox(height: 30),
          titleWidget(MyString.sharePeople),
          SizedBox(height: 15),
          peopleField(),
          SizedBox(height: 30),
          titleWidget(MyString.tips),
          SizedBox(height: 15),
          titleWidget(MyString.tipsContent),
        ],
      ),
    );
  }

  Widget titleWidget(String title) {
    return Text(title,
        style: TextStyle(color: context.textColor, fontSize: 14));
  }

  Widget titleField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: context.isDark
              ? MyColor.bgColorThirdNight
              : MyColor.bgColorThirdLight),
      child: TextField(
        maxLength: 100,
        maxLines: 2,
        cursorWidth: 2,
        cursorColor: context.hintColor,
        textInputAction: TextInputAction.next,
        controller: controllerTitle,
        onSubmitted: (String val) {
          // 点击软键盘的动作按钮时的回调
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
          hintText: MyString.titleHint,
        ),
      ),
    );
  }

  Widget linkField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: context.isDark
              ? MyColor.bgColorThirdNight
              : MyColor.bgColorThirdLight),
      child: TextField(
        maxLines: 4,
        cursorWidth: 2,
        cursorColor: context.hintColor,
        textInputAction: TextInputAction.next,
        controller: controllerLink,
        onSubmitted: (String val) {
          // 点击软键盘的动作按钮时的回调
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
          hintText: MyString.linkHint,
        ),
      ),
    );
  }

  Widget peopleField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: context.isDark
              ? MyColor.bgColorThirdNight
              : MyColor.bgColorThirdLight),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: titleWidget(userName),
      ),
    );
  }

  submit() {
    if (controllerTitle.text.isEmpty) return Toast.show(MyString.titleToast);
    if (controllerLink.text.isEmpty) return Toast.show(MyString.linkToast);
    var params = {'title': controllerTitle.text, 'link': controllerLink.text};
    DioManager.post(API.ADD_SHARED, params, (data) {
      Toast.show('分享成功');
      controllerTitle.text = controllerLink.text = '';
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }
}
