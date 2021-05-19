import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/widgets/article_item.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';

import 'package:provider/provider.dart';

///我的收藏
class CollectionPage extends StatefulWidget {
  const CollectionPage({Key key}) : super(key: key);

  @override
  createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var provider = BaseListProvider<Article>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<Article>>(
        create: (_) => provider,
        child: Scaffold(
          appBar: TitleBar('我的收藏'),
          body: Consumer<BaseListProvider<Article>>(builder: (_, provider, __) {
            return MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshListView(
                key: const Key('latest_list'),
                refreshIndicatorKey: _refreshIndicatorKey,
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: provider.hasMore,
                itemBuilder: (_, index) {
                  return ArticleItem(provider.list[index]);
                },
              ),
            );
          }),
        ));
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
    DioManager.get<ArticleList>(API.COLLECT_LIST + "$_page/json", {}, (data) {
      if (data != null) {
        provider.setHasMore(!data.over);
        if (_page == 0) {
          provider.list.clear();

          /// 刷新
          if (data.datas.isEmpty) {
            provider.setStateType(StateType.empty);
          } else {
            provider.addAll(data.datas);
          }
        } else {
          provider.addAll(data.datas);
        }
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
