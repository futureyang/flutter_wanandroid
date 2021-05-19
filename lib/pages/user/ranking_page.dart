import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/pointrank_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:provider/provider.dart';

///积分排行
class RankingPage extends StatefulWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  var provider = BaseListProvider<PointRank>();
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
    return ChangeNotifierProvider<BaseListProvider<PointRank>>(
        create: (_) => provider,
        child: Scaffold(
            backgroundColor: context.backgroundColor,
            appBar: TitleBar('积分排行'),
            body: Consumer<BaseListProvider<PointRank>>(
                builder: (_, provider, __) {
              return RefreshListView(
                refreshIndicatorKey: _refreshIndicatorKey,
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: provider.hasMore,
                itemBuilder: (_, index) {
                  return _itemRank(provider.list[index], index);
                },
              );
            })));
  }

  _itemRank(PointRank pointRank, int index) {
    return Container(

        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(17),
                child: Text('${index + 1}',
                    style: TextStyle(color: context.textColor, fontSize: 14)),
              ),
              Expanded(
                  child: Text(pointRank.username,
                      style:
                          TextStyle(color: context.textColor, fontSize: 14))),
              Padding(
                  padding: EdgeInsets.all(17),
                  child: Expanded(
                      child: Text(
                    '${pointRank.coinCount}',
                    style: TextStyle(color: context.textColor, fontSize: 14),
                  )))
            ],
          ),
          SizedBox(height: 1, child: Container(color: context.bgColorSecondary))
        ]));
  }

  Future<void> _onRefresh() async {
    _page = 0;
    await _getPointsRankList();
  }

  Future<void> _loadMore() async {
    _page++;
    await _getPointsRankList();
  }

  _getPointsRankList() {
    DioManager.get<PointRankList>(API.POINTS_RANK + "$_page/json", {}, (data) {
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
