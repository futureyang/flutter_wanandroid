import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/pages/search/search_page.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/utils/event_bus_util.dart';
import 'package:flutter_wanandroid/widgets/article_item.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

class SearchResultPage extends StatefulWidget {
  String searchValue;

  SearchResultPage({Key key, this.searchValue: ""}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }
}

class _SearchResultPageState extends State<SearchResultPage>
    with AutomaticKeepAliveClientMixin<SearchResultPage> {
  var provider = BaseListProvider<Article>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int _page = 0;

  var searchEvent;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    searchEvent = eventBus.on<SearchEvent>((event) {
      if (event.type == 1) {
        widget.searchValue = event.searchValue;
        _refreshIndicatorKey.currentState?.show();
      }
    });

    return ChangeNotifierProvider<BaseListProvider<Article>>(
      create: (_) => provider,
      child: Container(
        decoration: new BoxDecoration(
          color: context.bgColorSecondary,
        ),
        child: Consumer<BaseListProvider<Article>>(builder: (_, provider, __) {
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: RefreshListView(
                key: const Key('search_result_lsit'),
                refreshIndicatorKey: _refreshIndicatorKey,
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: provider.hasMore,
                itemBuilder: (_, index) {
                  return ArticleItem(
                      article: provider.list[index], itemCallback: () {});
                }),
          );
        }),
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
    DioManager.post<ArticleList>(
        API.QUERY + "$_page/json", {"k": widget.searchValue}, (data) {
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

  @override
  void dispose() {
    eventBus.off(searchEvent);
    super.dispose();
  }
}
