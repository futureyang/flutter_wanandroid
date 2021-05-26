import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/db/db_manager.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/res/gaps.dart';
import 'package:flutter_wanandroid/utils/device_utils.dart';
import 'package:flutter_wanandroid/widgets/title_bar.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  final String url, title;
  final Article article;

  const DetailPage(
      {Key key, @required this.title, @required this.url, this.article})
      : super(key: key);

  @override
  createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int _progressValue = 0;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (Device.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    saveHistory(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              if (snapshot.hasData) {
                final bool canGoBack = await snapshot.data.canGoBack();
                if (canGoBack) {
                  // 网页可以返回时，优先返回上一页
                  await snapshot.data.goBack();
                  return Future.value(false);
                }
              }
              return Future.value(true);
            },
            child: Scaffold(
              appBar: TitleBar(
                widget.title,
                icon: Icons.share,
                isShowRight: true,
                onRight: () {
                  Share.share('【${widget.title}】\n${widget.title}');
                },
              ),
              body: Stack(
                children: [
                  WebView(
                    initialUrl: widget.url,
                    javascriptMode: JavascriptMode.unrestricted,
                    allowsInlineMediaPlayback: true,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                      setState(() {
                        _progressValue = progress;
                      });
                    },
                  ),
                  if (_progressValue != 100)
                    LinearProgressIndicator(
                      value: _progressValue / 100,
                      backgroundColor: Colors.transparent,
                      minHeight: 2,
                    )
                  else
                    Gaps.empty,
                ],
              ),
            ),
          );
        });
  }

  saveHistory(Article article) async {
    if (article == null) return;
    ArticleEntity articleEntity = ArticleEntity.fromJson(article.toJson());
    List<ArticleEntity> list;
    list = await DataBaseManager.instance.getArticleDao().findAllArticles();
    if (list != null) {
      for (ArticleEntity datas in list) {
        if (datas.id == article.id) {
          DataBaseManager.instance.getArticleDao().deleteArticle(articleEntity);
        }
      }
    }
    DataBaseManager.instance.getArticleDao().insertArticle(articleEntity);
  }
}
