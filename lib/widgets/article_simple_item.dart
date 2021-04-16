import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/utils/string_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';

class ArticleSimpleItem extends StatefulWidget {
  const ArticleSimpleItem({Key key, this.article, this.itemCallback})
      : super(key: key);

  final Article article;

  final GestureTapCallback itemCallback;

  @override
  createState() => _ArticleSimpleItemState();
}

class _ArticleSimpleItemState extends State<ArticleSimpleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.itemCallback,
        child: Container(
          decoration: new BoxDecoration(
            color: context.backgroundColor,
          ),
          padding: const EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0),
          margin: const EdgeInsets.only(bottom: 6),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  widget.article.title.htmlToSpanned(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: context.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Offstage(
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "新",
                            style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 12),
                          )),
                      offstage: !widget.article.fresh,
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          widget.article.author.isNotEmpty
                              ? widget.article.author
                              : widget.article.shareUser,
                          style:
                              TextStyle(color: context.textColor, fontSize: 12),
                        )),
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          widget.article.niceDate,
                          style:
                              TextStyle(color: context.textColor, fontSize: 12),
                        )),
                    Expanded(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              _onCollect(
                                  widget.article.id, widget.article.collect);
                            },
                            tooltip: '收藏',
                            icon: widget.article.collect
                                ? Icon(
                                    Icons.star,
                                    color: context.hintColor,
                                  )
                                : Icon(Icons.star_border,
                                    color: context.hintColor),
                            iconSize: 20)
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _onCollect(int id, bool isCollect) async {
    DioManager.post<dynamic>(
        (isCollect ? API.UN_COLLECT_ORIGIN_ID : API.COLLECT) + '$id/json', {},
        (data) {
      setState(() {
        widget.article.collect = !(widget.article.collect);
      });
    }, (error) {
      Toast.show(error.errorMsg);
    });
  }
}
