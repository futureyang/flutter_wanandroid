import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class LatestPage extends StatefulWidget {
  const LatestPage({Key key}) : super(key: key);

  @override
  createState() => new _LatestPageState();
}

class _LatestPageState extends State<LatestPage> with TickerProviderStateMixin {
  var provider = BaseListProvider<Article>();

  int _page = 0;

  var articleList = <Article>[];

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<Article>>(
      create: (_) => provider,
      child: Container(
        child: Scaffold(
            backgroundColor: context.textColor,
            body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshListView(
                key: const Key('order_search_list'),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: provider.hasMore,
                itemBuilder: (_, index) {
                  return Container(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    child: _articleItem(provider.list[index]),
                  );
                },
              ),
            )),
      ),
    );
  }

  Widget _articleItem(Article article) {
    return Container(
      decoration: new BoxDecoration(
        color: context.backgroundColor,
      ),
      padding: EdgeInsets.all(30),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "置顶",
                style: TextStyle(
                    color: context.isDark
                        ? MyColor.colorBadgeNight
                        : MyColor.colorBadgeLight,
                    fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    _page = 0;
    await _getArticleList();
  }

  Future<void> _loadMore() async {
    _page++;
    await _getArticleList();
  }

  _getArticleList() {
    DioManager.get<ArticleList>(API.ARTICLE_LIST + "$_page/json", {}, (data) {
      if (data != null) {
        provider.setHasMore(!data.over);
        if (_page == 0) {
          /// 刷新
          provider.list.clear();
          if (data.datas.isEmpty) {
            provider.setStateType(StateType.empty);
          } else {
            provider.addAll(data.datas);
          }
        } else {
          provider.addAll(data.datas);
        }
        setState(() {});
      } else {
        /// 加载失败
        provider.setHasMore(false);
        provider.setStateType(StateType.network);
      }
    }, (error) {
      /// 加载失败
      provider.setHasMore(false);
      provider.setStateType(StateType.network);
    });
  }
}
