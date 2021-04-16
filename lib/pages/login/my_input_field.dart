import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

class MyInputField extends StatefulWidget {
  MyInputField(
      {Key key,
      this.textEditingController,
      this.hintText,
      this.isPassword = true,
      this.isShowRight = true,
      this.iconData = Icons.phone_android_rounded})
      : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  bool isPassword;
  final bool isShowRight;
  final IconData iconData;

  @override
  createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    widget.iconData,
                    color: context.textColor,
                  ),
                ),
                new Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: TextField(
                      maxLines: 1,
                      cursorWidth: 2,
                      cursorColor: context.hintColor,
                      controller: widget.textEditingController,
                      obscureText: widget.isPassword,
                      decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle:
                              TextStyle(fontSize: 15, color: context.hintColor),
                          contentPadding: EdgeInsets.only(left: 5.0),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Offstage(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        child: Icon(
                          widget.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: context.hintColor,
                          size: 16,
                        ),
                        onTap: () {
                          setState(() {
                            widget.isPassword = !widget.isPassword;
                          });
                        },
                      ),
                    ),
                    offstage: !widget.isShowRight)
              ],
            ),
            buildTitleLine(context)
          ],
        ));
  }

  // 下划线
  buildTitleLine(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: context.hintColor,
        height: 1.0,
      ),
    );
  }
}
