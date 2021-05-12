import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

/// 搜索页的AppBar
class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({
    Key key,
    this.onBack,
    this.onSearch,
    this.controller,
  }) : super(key: key);

  final Function() onBack;
  final Function(String) onSearch;
  final TextEditingController controller;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 48.0,
        height: 48.0,
        child: InkWell(
          onTap: () {
            _focus.unfocus();
            widget.onBack();
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
              key: const Key('search_back'),
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.arrow_back)),
        ),
      ),
    );

    final Widget textField = Expanded(
      child: Container(
        height: 32.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: context.isDark
                ? MyColor.bgColorThirdNight
                : MyColor.bgColorThirdLight),
        child: TextField(
          key: const Key('search_text_field'),
          controller: widget.controller,
          focusNode: _focus,
          maxLines: 1,
          cursorWidth: 2,
          cursorColor: context.hintColor,
          textInputAction: TextInputAction.search,
          onSubmitted: (String val) {
            _focus.unfocus();
            // 点击软键盘的动作按钮时的回调
            widget.onSearch(val);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15.0),
            border: InputBorder.none,
            hintText: '搜索关键词以空格隔开',
            suffixIcon: GestureDetector(
              child: Semantics(
                label: '清空',
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: context.textColor,
                  ),
                ),
              ),
              onTap: () {
                /// https://github.com/flutter/flutter/issues/35848
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  widget.controller.text = '';
                });
              },
            ),
          ),
        ),
      ),
    );
    //
    final Widget search = IconButton(
      icon: Icon(
        Icons.search,
        size: 20,
      ),
      onPressed: () {
        _focus.unfocus();
        widget.onSearch(widget.controller.text);
      },
    );

    return SafeArea(
        child: Container(
            color: context.backgroundColor,
            child: Column(
              children: [
                Row(
                  children: <Widget>[back, textField, search],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: context.shadowColor,
                    height: 2.0,
                  ),
                )
              ],
            )));
  }
}
