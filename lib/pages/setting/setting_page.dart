import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/common.dart';
import 'package:flutter_wanandroid/provider/theme_provider.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/utils/cache_util.dart';
import 'package:flutter_wanandroid/utils/login_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _selectValue = 0;
  final List<String> _themeList = <String>['跟随系统', '开启', '关闭'];
  List<SettingEntity> _settingList;
  final cacheUtil = CacheUtil();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.bgColorSecondary,
        appBar: TitleBar('系统设置'),
        body: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView.builder(
                itemCount: _settingList.length,
                itemBuilder: (context, index) {
                  if (index == 2 || index == 5) {
                    return SizedBox(height: 10);
                  } else if (index == 6) {
                    return _outLogin();
                  } else {
                    return _settingItem(index);
                  }
                })));
  }

  _initData() {
    final String theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        _selectValue = 1;
        break;
      case 'Light':
        _selectValue = 2;
        break;
      default:
        _selectValue = 0;
        break;
    }
    _settingList = [
      SettingEntity('夜间模式', _themeList[_selectValue]),
      SettingEntity('清除缓存', ''),
      SettingEntity('', ''),
      SettingEntity('检查版本', '已是最新版本'),
      SettingEntity('关于我们', 'v1.1'),
      SettingEntity('', ''),
      SettingEntity('', ''),
    ];
    _initPackageInfo();
    _initCache();
  }

  _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _settingList[4].value = 'v${packageInfo.version}';
    });
  }

  _initCache() async {
    var cache = await cacheUtil.loadCache();
    setState(() {
      _settingList[1].value = cache;
    });
  }

  _deleteCache() async {
    await cacheUtil.delDirCache().whenComplete(() {
      // _initCache();
      setState(() {
        _settingList[1].value = '0.00B';
      });
    });
  }

  _settingItem(int index) {
    return Column(children: [
      GestureDetector(
          child: Container(
              height: 45,
              color: context.backgroundColor,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                      child:
                          Text(_settingList[index].name, style: _textStyle())),
                  Text(
                    _settingList[index].value,
                    style: _textStyle(),
                  )
                ],
              )),
          onTap: () {
            onClack(index);
          }),
      SizedBox(height: 1, child: Container(color: context.bgColorSecondary))
    ]);
  }

  _outLogin() {
    return GestureDetector(
        child: Container(
          height: 45,
          color: context.backgroundColor,
          child: Center(
            child: Text('退出登录', style: _textStyle()),
          ),
        ),
        onTap: () => showOutLoginDialog());
  }

  _textStyle() {
    return TextStyle(color: context.textColor, fontSize: 14);
  }

  onClack(int index) {
    switch (index) {
      case 0:
        showThemeDialog();
        break;
      case 1:
        showCacheDialog();
        break;
      case 3:
        Toast.show('已是最新版本');
        break;
      case 4:
        NavigatorUtils.goDetailPage(context, '关于我们',
            'https://github.com/futureyang/flutter_wanandroid');
        break;
    }
  }

  showThemeDialog() {
    Widget cancelButton = GestureDetector(
      child: Text(
        "取消",
        style: TextStyle(color: context.textColor, fontSize: 14),
      ),
      onTap: () {
        Navigator.pop(context, '取消');
      },
    );

    Widget continueButton = GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "确定",
          style: TextStyle(color: context.textColor, fontSize: 14),
        ),
      ),
      onTap: () {
        setState(() {
          _settingList[0].value = _themeList[_selectValue];
        });
        final ThemeMode themeMode = _selectValue == 0
            ? ThemeMode.system
            : (_selectValue == 1 ? ThemeMode.dark : ThemeMode.light);
        context.read<ThemeProvider>().setTheme(themeMode);
        Navigator.pop(context, '确定');
      },
    );

    Widget _buildItem(int index, Function state) {
      return Material(
        type: MaterialType.transparency,
        child: InkWell(
          child: SizedBox(
            height: 42.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _themeList[index],
                    style: TextStyle(color: context.textSecondaryColor),
                  ),
                ),
                _selectValue == index
                    ? Icon(
                        Icons.check,
                        color: context.textColor,
                        size: 16,
                      )
                    : Text(''),
              ],
            ),
          ),
          onTap: () {
            if (mounted) {
              if (_selectValue != index) {
                state(() {
                  _selectValue = index;
                });
              }
            }
          },
        ),
      );
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: context.backgroundColor,
                title: Text('夜间模式', style: TextStyle(color: context.textColor)),
                content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        _themeList.length, (i) => _buildItem(i, state))),
                actions: [cancelButton, continueButton],
              );
            },
          );
        });
  }

  showOutLoginDialog() {
    Widget cancelButton = GestureDetector(
      child: Text(
        "取消",
        style: TextStyle(color: context.textColor, fontSize: 14),
      ),
      onTap: () {
        Navigator.pop(context, '取消');
      },
    );

    Widget continueButton = GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "确定",
          style: TextStyle(color: context.textColor, fontSize: 14),
        ),
      ),
      onTap: () {
        Navigator.pop(context, '确定');
        LoginUtil.outLogin(context);
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.backgroundColor,
          title: Text('提示',
              style: TextStyle(
                color: context.textColor,
              )),
          content: Text(
            '您确定要退出登录么 ?',
            style: TextStyle(color: context.textColor, fontSize: 14),
          ),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
  }

  showCacheDialog() {
    Widget cancelButton = GestureDetector(
      child: Text(
        "取消",
        style: TextStyle(color: context.textColor, fontSize: 14),
      ),
      onTap: () {
        Navigator.pop(context, '取消');
      },
    );

    Widget continueButton = GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "确定",
          style: TextStyle(color: context.textColor, fontSize: 14),
        ),
      ),
      onTap: () {
        Navigator.pop(context, '确定');
        _deleteCache();
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.backgroundColor,
          title: Text('提示',
              style: TextStyle(
                color: context.textColor,
              )),
          content: Text(
            '确认清除缓存 ?',
            style: TextStyle(color: context.textColor, fontSize: 14),
          ),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
  }
}

class SettingEntity {
  String name;
  String value;

  SettingEntity(this.name, this.value);
}
