import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/gaps.dart';
import 'package:flutter_wanandroid/utils/device_utils.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_wanandroid/utils/theme_utils.dart';

class DetailPage extends StatefulWidget {
  final String url, title;

  const DetailPage({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int _progressValue = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Device.isAndroid) {
  //     WebView.platform = SurfaceAndroidWebView();
  //   }
  // }

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
              appBar: AppBar(
                title: Text(widget.title),
                elevation: 2,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 20,
                      color: context.textColor,
                    ),
                    tooltip: '分享',
                    onPressed: () {
                      Share.share('【${widget.title}】\n${widget.title}');
                    },
                  ),
                ],
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
}
