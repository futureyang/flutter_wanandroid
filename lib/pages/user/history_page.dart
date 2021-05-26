import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/db/db_manager.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/res/strings.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/article_entity_simple_item.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:provider/provider.dart';

///浏览历史
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var provider = BaseListProvider<ArticleEntity>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<ArticleEntity>>(
      create: (_) => provider,
      child: Scaffold(
        appBar: TitleBar('浏览历史'),
        body: Consumer<BaseListProvider<ArticleEntity>>(
            builder: (_, provider, __) {
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: RefreshListView(
              refreshIndicatorKey: _refreshIndicatorKey,
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _onRefresh,
              hasMore: provider.hasMore,
              itemBuilder: (_, index) {
                return ArticleEntitySimpleItem(
                  provider.list[index],
                  onLong: () => showAlertDialog(index),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await _getArticleList();
  }

  _getArticleList() async {
    List<ArticleEntity> list;
    list = await DataBaseManager.instance.getArticleDao().findAllArticles();
    provider.list.clear();
    if (list.isEmpty) {
      provider.setStateType(StateType.empty);
    } else {
      provider.addAll(list);
    }
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
        deleteHistory(provider.list[index]);
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
            MyString.confirmDeleteHistory,
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

  deleteHistory(ArticleEntity articleEntity) async {
    provider.remove(articleEntity);
    DataBaseManager.instance.getArticleDao().deleteArticle(articleEntity);
    Toast.show('删除成功');
  }
}
