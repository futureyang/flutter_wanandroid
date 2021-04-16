import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/utils/string_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';

class ArticleItme extends StatefulWidget {
  const ArticleItme({Key key, this.article, this.itemCallback})
      : super(key: key);

  final Article article;

  final GestureTapCallback itemCallback;

  @override
  createState() => _ArticleItmeState();
}

class _ArticleItmeState extends State<ArticleItme> {
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
              Row(
                children: [
                  Offstage(
                    child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          "置顶",
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12),
                        )),
                    offstage: !widget.article.top,
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
                  Offstage(
                    child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: context.textColor, width: 0.8),
                          //边框
                          borderRadius: BorderRadius.all(
                            //圆角
                            Radius.circular(2.0),
                          ),
                        ),
                        child: Text(
                          widget.article.tags.isEmpty
                              ? ""
                              : widget.article.tags[0].name,
                          style:
                              TextStyle(color: context.textColor, fontSize: 10),
                        )),
                    offstage: widget.article.tags.isEmpty,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formChapter(widget.article),
                        style:
                            TextStyle(color: context.hintColor, fontSize: 12),
                      )
                    ],
                  ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
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
              Offstage(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    widget.article.desc.htmlToSpanned(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: context.textSecondaryColor, fontSize: 13),
                  ),
                ),
                offstage: widget.article.desc.isEmpty,
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

  formChapter(Article article) {
    if (article.superChapterName.isEmpty) {
      return article.chapterName.htmlToSpanned();
    } else if (article.chapterName.isEmpty) {
      return article.superChapterName.htmlToSpanned();
    } else {
      return "${article.superChapterName.htmlToSpanned()}/${article.chapterName.htmlToSpanned()}";
    }
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
