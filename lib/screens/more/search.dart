import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class WebSearch extends StatefulWidget {
  const WebSearch({super.key});

  @override
  State<WebSearch> createState() => _WebSearchState();
}

class _WebSearchState extends State<WebSearch> {

  @override
  void initState(){
    super .initState();
    if(Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const WebView(
      initialUrl: 'https://www.drugs.com/',
     ),
    );
  }
}