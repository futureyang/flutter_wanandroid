import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/res/strings.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/router/routers.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/article_simple_item.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:provider/provider.dart';

///我的分享列表
class ShareListPage extends StatefulWidget {
  const ShareListPage({Key key}) : super(key: key);

  @override
  createState() => _ShareListPageState();
}

class _ShareListPageState extends State<ShareListPage> {
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
          backgroundColor: provider.list.length == 0
              ? context.backgroundColor
              : context.bgColorSecondary,
          appBar:
              TitleBar('我的分享', icon: Icons.add, isShowRight: true, onRight: () {
            NavigatorUtils.push(context, Routes.sharePage);
          }),
          body: Consumer<BaseListProvider<Article>>(builder: (_, provider, __) {
            return MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshListView(
                refreshIndicatorKey: _refreshIndicatorKey,
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: provider.hasMore,
                itemBuilder: (_, index) {
                  return ArticleSimpleItem(provider.list[index], onLong: () {
                    showAlertDialog(index);
                  });
                },
              ),
            );
          }),
        ));
  }

  showAlertDialog(int index) {
    //设置按钮
    Widget cancelButton = GestureDetector(
      child: Text(
        "取消",
        style: TextStyle(color: context.textColor, fontSize: 14),
      ),
      onTap: () {
        Navigator.pop(context, 'Cancel');
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
        deleteShare(provider.list[index].id);
        provider.list.removeAt(index);
        if (provider.list.length == 0) {
          provider.setStateType(StateType.empty);
        }
        Navigator.pop(context, 'Cancel');
      },
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.backgroundColor,
          content: Text(
            MyString.confirmDeleteShared,
            style: TextStyle(color: context.textColor, fontSize: 16),
          ),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
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
    DioManager.get<ShareArticleList>(
        API.SHARED_ARTICLE_LIST + "$_page/json", {}, (data) {
      if (data != null) {
        provider.setHasMore(!data.shareArticles.over);
        if (_page == 0) {
          provider.list.clear();

          /// 刷新
          if (data.shareArticles.datas.isEmpty) {
            provider.setStateType(StateType.empty);
          } else {
            provider.addAll(data.shareArticles.datas);
          }
        } else {
          provider.addAll(data.shareArticles.datas);
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

  deleteShare(int id) {
    DioManager.post(API.DELETE_SHARED + "$id/json", {},
        (data) => Toast.show('删除成功'), (error) => Toast.show(error.errorMsg));
  }
}
