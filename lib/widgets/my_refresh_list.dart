import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/gaps.dart';
import 'package:flutter_wanandroid/res/styles.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

import 'overscroll_behavior.dart';
import 'state_layout.dart';

/// 封装下拉刷新与加载更多
class RefreshListView extends StatefulWidget {
  const RefreshListView({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onRefresh,
    this.loadMore,
    this.hasMore = false,
    this.stateType = StateType.empty,
    this.pageSize = 20,
    this.padding,
    this.itemExtent,
    this.refreshIndicatorKey,
    this.physics,
  }) : super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final ScrollPhysics physics;

  /// 一页的数量
  final int pageSize;

  /// padding属性使用时注意会破坏原有的SafeArea，需要自行计算bottom大小
  final EdgeInsetsGeometry padding;
  final double itemExtent;

  @override
  _RefreshListViewState createState() => _RefreshListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _RefreshListViewState extends State<RefreshListView> {
  /// 是否正在加载数据
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Widget child = RefreshIndicator(
        key: widget.refreshIndicatorKey,
        onRefresh: widget.onRefresh,
        child: widget.itemCount == 0
            ? StateLayout(type: widget.stateType)
            : ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: ListView.builder(
                  itemCount: widget.loadMore == null
                      ? widget.itemCount
                      : widget.itemCount + 1,
                  padding: widget.padding,
                  shrinkWrap: true,
                  physics: widget.physics,
                  itemBuilder: (BuildContext context, int index) {
                    /// 不需要加载更多则不需要添加FootView
                    if (widget.loadMore == null) {
                      return widget.itemBuilder(context, index);
                    } else {
                      return index < widget.itemCount
                          ? widget.itemBuilder(context, index)
                          : MoreWidget(widget.itemCount, widget.hasMore,
                              widget.pageSize);
                    }
                  },
                ),
              ));
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification note) {
          /// 确保是垂直方向滚动，且滑动至底部
          if (note.metrics.pixels == note.metrics.maxScrollExtent &&
              note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: child,
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize, {Key key})
      : super(key: key);

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.isDark
        ? TextStyles.textGray14
        : const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (hasMore) const CupertinoActivityIndicator(),
          if (hasMore) Gaps.hGap5,

          /// 只有一页的时候，就不显示FooterView了
          Text(hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有了呦~'),
              style: style),
        ],
      ),
    );
  }
}
