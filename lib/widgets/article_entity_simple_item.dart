import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/network/dio_manager.dart';
import 'package:flutter_wanandroid/pages/detail/detail_page.dart';
import 'package:flutter_wanandroid/router/fluro_navigator.dart';
import 'package:flutter_wanandroid/utils/string_util.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';
import 'package:flutter_wanandroid/utils/toast_util.dart';

class ArticleEntitySimpleItem extends StatefulWidget {
  const ArticleEntitySimpleItem(this.article, {Key key, this.onLong})
      : super(key: key);

  final ArticleEntity article;

  final Function() onLong;

  @override
  createState() => _ArticleEntitySimpleItemState();
}

class _ArticleEntitySimpleItemState extends State<ArticleEntitySimpleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailPage(
                title: widget.article.title,
                url: widget.article.link,
                article: Article().fromJson(widget.article.toJson()));
          }));
        },
        onLongPress: widget.onLong,
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
                margin: EdgeInsets.only(top: 15, bottom: 15),
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
                          formAuthor(widget.article),
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
                    // Expanded(
                    //     child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         _onCollect(
                    //             widget.article.id, widget.article.collect);
                    //       },
                    //       child: Icon(
                    //         widget.article.collect
                    //             ? Icons.star
                    //             : Icons.star_border,
                    //         color: context.hintColor,
                    //         size: 20,
                    //       ),
                    //     )
                    //   ],
                    // ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  formAuthor(ArticleEntity article) {
    if (article.author.isNotEmpty) {
      return article.author;
    } else if (article.shareUser.isNotEmpty) {
      return article.shareUser;
    }
    return '匿名';
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
