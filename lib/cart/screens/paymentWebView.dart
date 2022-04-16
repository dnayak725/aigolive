import 'dart:async';
import 'package:aigolive/account-setting/orders/screens/my_purchases_screen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final Completer<WebViewController> _webViewController =
      Completer<WebViewController>();
  final String url;
  final String redirectUrl;
  PaymentWebView({
    this.url,
    this.redirectUrl,
  });
  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  MyColors mycolor = new MyColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mycolor.blueDark, mycolor.blueLight],
            ),
          ),
        ),
        elevation: 0,
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            widget._webViewController.complete(webViewController);
          },
          onPageStarted: (pageUrl) {
            List urlParts = pageUrl.split("=");
            if (urlParts[urlParts.length - 1] == "completed") {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => MyPurchasesScreen(0, true),
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
