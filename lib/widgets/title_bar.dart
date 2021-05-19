import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowRight;
  final IconData icon;
  final Function() onRight;
  final Widget rightWidget;

  const TitleBar(this.title,
      {Key key,
      this.onRight,
      this.icon,
      this.isShowRight = false,
      this.rightWidget})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 48.0,
        height: 48.0,
        child: InkWell(
          onTap: () {
            NavigatorUtils.goBack(context);
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
              key: const Key('search_back'),
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.arrow_back)),
        ),
      ),
    );

    final Widget titleWidget = Expanded(
        child: Text(title,
            style: TextStyle(fontSize: 18, color: context.textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center));

    final Widget rightIcon = Visibility(
        visible: isShowRight,
        maintainState: true,
        maintainSize: true,
        maintainAnimation: true,
        maintainSemantics: true,
        maintainInteractivity: true,
        child: Semantics(
          label: '返回',
          child: SizedBox(
            width: 48.0,
            height: 48.0,
            child: InkWell(
              onTap: () => isShowRight ? onRight() : null,
              borderRadius: BorderRadius.circular(24.0),
              child: Padding(
                  key: const Key('search_back'),
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    icon,
                    size: 20,
                    color: context.textColor,
                  )),
            ),
          ),
        ));

    return SafeArea(
      child: Container(
        color: context.backgroundColor,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                back,
                titleWidget,
                rightWidget == null ? rightIcon : rightWidget
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: context.shadowColor,
                height: 2.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
