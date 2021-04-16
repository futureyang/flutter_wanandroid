import 'package:flutter_wanandroid/res/dimens.dart';
import 'package:flutter_wanandroid/res/gaps.dart';
import 'package:flutter_wanandroid/res/strings.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'load_image.dart';

/// design/9暂无状态页面/index.html#artboard3
class StateLayout extends StatelessWidget {
  const StateLayout({Key key, @required this.type, this.hintText})
      : super(key: key);

  final StateType type;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (type == StateType.loading)
          const CupertinoActivityIndicator(radius: 16.0)
        else if (type == StateType.empty)
          _noData(context),
        const SizedBox(
          width: double.infinity,
          height: Dimens.gap_dp16,
        ),
        Text(
          hintText ?? type.hintText,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50,
      ],
    );
  }

  Widget _noData(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(Icons.info_outline, size: 100, color: context.hintColor),
          Text(
            MyString.noData,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }
}

enum StateType {
  /// 无网络
  network,

  /// 加载中
  loading,

  /// 空
  empty,

  /// 完成
  completed,

  /// 结束
  end
}

extension StateTypeExtension on StateType {

  String get hintText =>
      <String>['无网络连接', '加载中', '暂时没有数据', '', ''][index];
}
