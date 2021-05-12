import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/category_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/pages/main/hierarchy/hierarch_list_page.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';

// 体系
class HierarchyPage extends StatefulWidget {
  const HierarchyPage({Key key}) : super(key: key);

  @override
  createState() => new _HierarchyPageState();
}

class _HierarchyPageState extends State<HierarchyPage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HierarchyPage> {
  var _controller; //tab控制器
  var _scrollController; //tab控制器

  int _currentIndex = 0; //选中下标

  List<Category> listCartgory = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getArticleCategory();
    //初始化controller
    _controller = TabController(vsync: this, length: 0);
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
                  elevation: 3,
                  shadowColor: context.shadowColor,
                  backgroundColor: context.backgroundColor,
                ),
              ];
            },
            body: _tabBarView()));
  }

  Widget _toobar() {
    return SafeArea(
      top: false,
      child: Container(
        child: Row(
          children: [
            // Visibility(
            //     visible: false,
            //     maintainState: true,
            //     maintainSize: true,
            //     maintainAnimation: true,
            //     maintainSemantics: true,
            //     maintainInteractivity: true,
            //     child: Icon(
            //       Icons.add,
            //       size: 20,
            //       color: context.textColor,
            //     )),
            Expanded(
                child: Text('体系',
                    style: TextStyle(fontSize: 16, color: context.textColor),
                    textAlign: TextAlign.center)),
            // IconButton(
            //   icon: Icon(
            //     Icons.import_contacts,
            //     size: 20,
            //     color: context.textColor,
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
        controller: _controller,
        //选中的颜色
        labelColor: context.textColor,
        //选中的样式
        labelStyle: TextStyle(fontSize: 15),
        //未选中的颜色
        unselectedLabelColor: context.hintColor,
        //未选中的样式
        unselectedLabelStyle: TextStyle(fontSize: 14),
        //设置边距
        labelPadding: EdgeInsets.only(left: 8, right: 8),
        //下划线颜色
        indicatorColor: context.textColor,
        isScrollable: true,
        tabs: listCartgory.map((Category category) {
          return Tab(
            text: category.name,
          );
        }).toList(),
        onTap: (index) {
          _currentIndex = index;
        });
  }

  Widget _tabBarView() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: TabBarView(
          controller: _controller,
          children: listCartgory.map((Category category) {
            return HierarchyListPage(category);
          }).toList()),
    );
  }

  getArticleCategory() {
    DioManager.get<List<Category>>(API.TREE, {}, (data) {
      setState(() {
        listCartgory = data;
        _controller = TabController(vsync: this, length: listCartgory.length);
      });
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }
}
