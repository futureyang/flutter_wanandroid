import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

///开源许可
class OpenSourcePage extends StatefulWidget {
  const OpenSourcePage({Key key}) : super(key: key);

  @override
  createState() => _OpenSourcePageState();
}

class _OpenSourcePageState extends State<OpenSourcePage> {
  List<OpenSourceEntity> datas = [
    OpenSourceEntity('Dio', 'https://github.com/flutterchina/dio'),
    OpenSourceEntity('RxDart', 'https://github.com/ReactiveX/rxdart'),
    OpenSourceEntity('Provider', 'https://github.com/rrousselGit/provider'),
    OpenSourceEntity('Toast', 'https://github.com/OpenFlutter/flutter_oktoast'),
    OpenSourceEntity('Flustars', 'https://github.com/Sky24n/flustars'),
    OpenSourceEntity('CachedNetworkImage',
        'https://github.com/renefloor/flutter_cached_network_image'),
    OpenSourceEntity('Html', 'https://pub.flutter-io.cn/packages/html'),
    OpenSourceEntity('Cookie', 'https://github.com/flutterchina/cookie_jar'),
    OpenSourceEntity('DioCookieManager',
        'https://github.com/flutterchina/dio/tree/master/plugins/cookie_manager'),
    OpenSourceEntity('PathProvider', 'https://pub.dev/packages/path_provider'),
    OpenSourceEntity(
        'Floor', 'https://pub.flutter-io.cn/packages/floor_generator'),
    OpenSourceEntity('EventBus', 'https://pub.dev/packages/event_bus'),
    OpenSourceEntity('WebviewFlutter',
        'https://github.com/flutter/plugins/tree/master/packages/webview_flutter'),
    OpenSourceEntity('Share',
        'https://github.com/flutter/plugins/tree/master/packages/share'),
    OpenSourceEntity(
        'FlutterSwiper', 'https://github.com/best-flutter/flutter_swiper'),
    OpenSourceEntity('StickyHeaders',
        'https://github.com/fluttercommunity/flutter_sticky_headers'),
    OpenSourceEntity('PackageInfo',
        'https://pub.flutter-io.cn/packages/package_info'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar('开源许可'),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: datas.length,
            itemBuilder: (context, index) {
              return _item(index);
            }),
      ),
    );
  }

  Widget _item(int index) {
    return GestureDetector(
      child: Container(
        color: context.backgroundColor,
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
        margin: EdgeInsets.only(bottom: 1),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            datas[index].name,
            style: TextStyle(
                color: context.textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          Text(
            datas[index].link,
            style: TextStyle(color: context.textSecondaryColor, fontSize: 12),
          ),
        ]),
      ),
      onTap: () => NavigatorUtils.goDetailPage(
          context, datas[index].name, datas[index].link),
    );
  }
}

class OpenSourceEntity {
  String name;
  String link;

  OpenSourceEntity(this.name, this.link);
}
