import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/userinfo_entity.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/router/routers.dart';
import 'package:flutter_wanandroid/utils/login_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key key}) : super(key: key);

  @override
  createState() => new _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin<MinePage> {
  List<MineEntity> mineList = [
    MineEntity.empty(),
    MineEntity(Icons.local_atm, "我的积分", Routes.integralPage, isLogin: true),
    MineEntity(Icons.emoji_events_outlined, "积分排行", Routes.rankingPage),
    MineEntity.empty(),
    MineEntity(Icons.control_point, "我的分享", Routes.shareListPage, isLogin: true),
    MineEntity(Icons.star_border, "我的收藏", Routes.collectPage, isLogin: true),
    MineEntity(Icons.restore, "浏览历史", Routes.historyPage),
    MineEntity.empty(),
    MineEntity(Icons.code, "开源许可", Routes.openSourcePage),
    MineEntity(Icons.psychology_outlined, "关于作者", Routes.aboutAuthorPage),
    MineEntity(Icons.settings_outlined, "系统设置", Routes.settingPage),
  ];

  UserInfo userInfo;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    userInfo = LoginUtil.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(toolbarHeight: 0, backgroundColor: context.backgroundColor),
        backgroundColor: context.bgColorSecondary,
        body: Container(
          child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView(
              children: [
                Container(
                  color: context.backgroundColor,
                  child: GestureDetector(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Icon(
                            Icons.android_rounded,
                            size: 100,
                            color: context.textColor,
                          ),
                          SizedBox(height: 30),
                          Text(userInfo == null ? '登录/注册' : userInfo.nickname,
                              style: TextStyle(
                                  color: context.textColor, fontSize: 18)),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (userInfo != null) return;
                      NavigatorUtils.push(context, Routes.loginPage);
                    },
                  ),
                ),
                ListView.builder(
                    physics: new NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: mineList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0 || index == 3 || index == 7) {
                        return SizedBox(height: 10);
                      } else {
                        return _itemMine(index);
                      }
                    })
              ],
            ),
          ),
        ));
  }

  Widget _itemMine(int index) {
    return Column(children: [
      GestureDetector(
        child: Container(
          color: context.backgroundColor,
          padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
          child: Row(
            children: [
              Icon(mineList[index].icon, color: context.textColor, size: 22),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  mineList[index].title,
                  style: TextStyle(color: context.textColor, fontSize: 15),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (mineList[index].isLogin) {
            LoginUtil.checkLogin(context, () {
              NavigatorUtils.push(context, mineList[index].path);
            });
          } else {
            NavigatorUtils.push(context, mineList[index].path);
          }
        },
      ),
      SizedBox(height: 1, child: Container(color: context.bgColorSecondary)),
    ]);
  }
}

class MineEntity {
  IconData icon;
  String title;
  String path;
  bool isLogin;

  MineEntity.empty();

  MineEntity(this.icon, this.title, this.path, {this.isLogin = false});
}
