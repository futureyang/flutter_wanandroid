import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/main/home/wechat_page.dart';
import 'package:flutter_wanandroid/res/strings.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';

import 'latest_page.dart';
import 'palaza_page.dart';
import 'popular_page.dart';
import 'project_page.dart';
import 'questions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomePage> {
  var _controller; //tab控制器
  var _scrollController; //tab控制器

  int _currentIndex = 0; //选中下标

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //初始化controller
    _controller = TabController(vsync: this, length: 6);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
        backgroundColor: context.backgroundColor,
        body: new NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                    title: _toobar(),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: _tabBar(),
                    elevation: 2,
                    shadowColor: context.hintColor),
              ];
            },
            body: _tabBarView()));
  }

  Widget _toobar() {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(7),
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: context.hintColor,
                  )),
              Text('搜索关键词以空格隔开',
                  style: TextStyle(color: context.hintColor, fontSize: 14))
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black12)),
    );
  }

  Widget _tabBar() {
    return TabBar(
        controller: _controller,
        //选中的颜色
        labelColor: context.textColor,
        //选中的样式
        labelStyle: TextStyle(fontSize: 16),
        //未选中的颜色
        unselectedLabelColor: context.hintColor,
        //未选中的样式
        unselectedLabelStyle: TextStyle(fontSize: 15),
        //设置边距
        labelPadding: EdgeInsets.zero,
        //下划线颜色
        indicatorColor: context.textColor,
        tabs: [
          Tab(text: MyString.popular),
          Tab(text: MyString.latest),
          Tab(text: MyString.plaza),
          Tab(text: MyString.questions),
          Tab(text: MyString.project),
          Tab(text: MyString.officialAccount),
        ],
        onTap: (index) {
          _currentIndex = index;
        });
  }

  Widget _tabBarView() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: TabBarView(controller: _controller, children: [
        PopularPage(),
        LatestPage(),
        PalzaPage(),
        QuestionsPage(),
        ProjectPage(),
        WeChatPage()
      ]),
    );
  }
}
