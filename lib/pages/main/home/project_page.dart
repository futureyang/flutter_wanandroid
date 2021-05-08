import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/entity/category_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/widgets/article_item.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:provider/provider.dart';

/// home/项目
class ProjectPage extends StatefulWidget {
  const ProjectPage({Key key}) : super(key: key);

  @override
  createState() => new _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin<ProjectPage> {
  var categoryList = <Category>[];
  var provider = BaseListProvider<Article>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int _page = 0;
  int _checkCategoryId = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<BaseListProvider<Article>>(
      create: (_) => provider,
      child: Container(
          decoration: new BoxDecoration(
            color: context.bgColorSecondary,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 4, top: 4, right: 5),
                margin: EdgeInsets.only(bottom: 5),
                decoration: new BoxDecoration(
                  color: context.backgroundColor,
                ),
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _categoryItem(categoryList[index]);
                  },
                ),
              ),
              Expanded(
                child: Consumer<BaseListProvider<Article>>(
                    builder: (_, provider, __) {
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
              )
            ],
          )),
    );
  }

  Widget _categoryItem(Category category) {
    bool isSelect = _checkCategoryId == category.id;
    return GestureDetector(
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: isSelect
              ? context.isDark
                  ? MyColor.bgColorThirdNight
                  : MyColor.bgColorThirdLight
              : context.isDark
                  ? MyColor.bgColorSecondaryNight
                  : MyColor.bgColorSecondaryLight,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.only(left: 13, right: 13),
        margin: EdgeInsets.all(5.0),
        child: Text(
          category.name,
          style: TextStyle(
              fontSize: 12,
              color: isSelect ? context.textColor : context.hintColor),
        ),
      ),
      onTap: () {
        _checkCategoryId = category.id;
        _refreshIndicatorKey.currentState?.show();
        setState(() {});
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

  _getCategoryList() {
    DioManager.get<List<Category>>(API.PROJECT, {}, (data) {
      if (data.isNotEmpty) {
        categoryList = data;
        _checkCategoryId = categoryList[0].id;
        _refreshIndicatorKey.currentState?.show();
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

  _getArticleList() {
    DioManager.get<ArticleList>(
        API.ARTICLE_LIST + "$_page/json", {"cid": _checkCategoryId}, (data) {
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
