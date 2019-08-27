import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Swebview extends StatefulWidget {
  Map arguments;

  Swebview({this.arguments}) ;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebSate(arguments: arguments);
  }
}

class WebSate extends State {
  Map arguments;

  WebSate({this.arguments});

  WebViewController _webViewController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_webViewController != null) _webViewController = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(// 监听返回键
        child: Scaffold(
          appBar: AppBar(
            title: Text(arguments['title'],style: TextStyle(fontSize: 16),),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,size: 16),
                onPressed: () {
                  _goBack(context);
                }),
          ),
          body: WebView(
            onWebViewCreated: (WebViewController web) {
              _webViewController = web;
              web.loadUrl(arguments['link']);
            },
            onPageFinished: (url) {
              print("onPageFinished = $url");
            },
          ),
        ),
        onWillPop: () {
          _goBack(context);
        });
  }

  void _goBack(BuildContext context) {
    if (_webViewController == null) return;
    _webViewController.canGoBack().then((goback) {
      if (goback)
        _webViewController.goBack();
      else
        Navigator.of(context).pop();
    });
  }
}
