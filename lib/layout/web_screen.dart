import 'package:flutter/material.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const String routName = "WebViewScreen";
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    var artical = ModalRoute.of(context)?.settings.arguments as Articles;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate())
      ..loadRequest(Uri.parse(artical.url ?? ""));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            )),
        backgroundColor: Color(0xFF39A552),
        title: Text(artical.title ?? ""),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
