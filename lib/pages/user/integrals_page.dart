import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/pointrank_entity.dart';
import 'package:flutter_wanandroid/entity/pointrecord_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/provider/base_list_provider.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';
import 'package:flutter_wanandroid/widgets/my_refresh_list.dart';
import 'package:flutter_wanandroid/widgets/overscroll_behavior.dart';
import 'package:flutter_wanandroid/widgets/rise_number_text.dart';
import 'package:flutter_wanandroid/widgets/state_layout.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:provider/provider.dart';

///我的积分
class IntegralsPage extends StatefulWidget {
  const IntegralsPage({Key key}) : super(key: key);

  @override
  createState() => _IntegralsPageState();
}

class _IntegralsPageState extends State<IntegralsPage> {
  var provider = BaseListProvider<PointRecord>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int _page = 0;

  PointRank pointRank = PointRank();

  @override
  void initState() {
    _getPoints();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: TitleBar('我的积分'),
        body: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView(
              children: [
                SizedBox(height: 20),
                Center(
                    child: RiseNumberText(pointRank.coinCount,
                        style: TextStyle(
                            color: context.textColor,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5))),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text('等级${pointRank.level}',
                              style: TextStyle(
                                  color: context.textColor, fontSize: 14))),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('排名${pointRank.rank}',
                              style: TextStyle(
                                  color: context.textColor, fontSize: 14))),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ChangeNotifierProvider<BaseListProvider<PointRecord>>(
                    create: (_) => provider,
                    child: Consumer<BaseListProvider<PointRecord>>(
                        builder: (_, provider, __) {
                      return RefreshListView(
                        physics: NeverScrollableScrollPhysics(),
                        //禁用滑动事件
                        refreshIndicatorKey: _refreshIndicatorKey,
                        itemCount: provider.list.length,
                        stateType: provider.stateType,
                        onRefresh: _onRefresh,
                        loadMore: _loadMore,
                        hasMore: provider.hasMore,
                        itemBuilder: (_, index) {
                          return _itemPointsRecord(provider.list[index]);
                        },
                      );
                    }))
              ],
            )));
  }

  _itemPointsRecord(PointRecord pointRecord) {
    return Container(
      color: context.backgroundColor,
      padding: EdgeInsets.all(10),
      child: Column(children: [
        SizedBox(height: 1, child: Container(color: context.bgColorSecondary)),
        Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(pointRecord.reason,
                      style:
                          TextStyle(color: context.textColor, fontSize: 14))),
              Padding(
                  padding: EdgeInsets.all(6),
                  child: Text(pointRecord.desc,
                      style: TextStyle(
                          color: context.textSecondaryColor, fontSize: 12))),
            ]),
          ),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text('+${pointRecord.coinCount}',
                  style: TextStyle(color: context.textColor, fontSize: 20)))
        ])
      ]),
    );
  }

  _getPoints() {
    DioManager.get<PointRank>(API.POINTS, {}, (data) {
      setState(() {
        pointRank = data;
      });
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }

  Future<void> _onRefresh() async {
    _page = 0;
    await _getPointsRecordList();
  }

  Future<void> _loadMore() async {
    _page++;
    await _getPointsRecordList();
  }

  _getPointsRecordList() {
    DioManager.get<PointRecordList>(API.POINTS_RECORD + "$_page/json", {},
        (data) {
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
