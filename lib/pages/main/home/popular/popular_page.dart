import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/string_util.dart';
import 'package:flutter_wanandroid/widgets/article_item.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key key}) : super(key: key);

  @override
  createState() => new _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  var provider = BaseListProvider<Article>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int _page = 0;

  var articleList = <Article>[];

  @override
  void initState() {
    super.initState();
    // _onRefresh();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              key: const Key('order_search_list'),
              refreshIndicatorKey: _refreshIndicatorKey,
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _onRefresh,
              loadMore: _loadMore,
              hasMore: provider.hasMore,
              itemBuilder: (_, index) {
                return ArticleItme(
                    article: provider.list[index], itemCallback: () {});
              },
            ),
          );
        }),
      ),
    );
  }

  formChapter(Article article) {
    if (article.superChapterName.isEmpty) {
      return article.chapterName.htmlToSpanned();
    } else if (article.chapterName.isEmpty) {
      return article.superChapterName.htmlToSpanned();
    } else {
      return "${article.superChapterName.htmlToSpanned()}/${article.chapterName.htmlToSpanned()}";
    }
  }

  Future<void> _onRefresh() async {
    _page = 0;
    await _getTopArticleList();
  }

  Future<void> _loadMore() async {
    _page++;
    await _getArticleList();
  }

  ///获取置顶文章
  _getTopArticleList() {
    DioManager.get<List<Article>>(API.ARTICLE_LIST_TOP, {}, (data) {
      if (data != null) {
        provider.list.clear();
        data.forEach((data) {
          data.top = true;
        });
        provider.addAll(data);
      }
      _getArticleList();
    }, (error) {
      /// 加载失败
      provider.setHasMore(false);
      provider.setStateType(StateType.network);
    });
  }

  _getArticleList() {
    DioManager.get<ArticleList>(API.ARTICLE_LIST + "$_page/json", {}, (data) {
      if (data != null) {
        provider.setHasMore(!data.over);
        if (_page == 0) {
          /// 刷新
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
