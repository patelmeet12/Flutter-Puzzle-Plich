import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class mWebView extends StatefulWidget {
  const mWebView({Key? key}) : super(key: key);

  @override
  _mWebViewState createState() => _mWebViewState();
}

class _mWebViewState extends State<mWebView> {
  late WebViewController mController;
  String myUrl = 'https://flutter.github.io/samples/web/slide_puzzle/#/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Puzzle Plich'),
          centerTitle: true,
          actions: [
            IconButton(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              icon: Icon( Icons.arrow_back, size: 28.0 ),
              onPressed: () async {
                if(await mController.canGoBack()) {
                  mController.goBack();
                }
              },
            ),
            IconButton(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              icon: Icon( Icons.refresh, size: 28.0 ),
              onPressed: () {
                mController.reload();
              },
            ),
          ],
        ),
        body: WillPopScope(
            onWillPop: () async {
              String? url = await mController.currentUrl();
              if (url == myUrl) {
                return true;
              } else {
                mController.goBack();
                return false;
              }
            },
            child: SafeArea(
                child: WebView(
              initialUrl: myUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (_controller) {
                this.mController = _controller;
              },
            ))));
  }
}