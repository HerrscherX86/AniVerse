import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

// Screen to display web content using WebView
class WebViewScreen extends StatefulWidget {
  final String url;

  // Constructor to initialize with the URL
  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;  // Controller to manage WebView

  @override
  void initState() {
    super.initState();
    // Set the WebView platform for Android to use SurfaceAndroidWebView
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,  // Set the initial URL to be loaded
        javascriptMode: JavascriptMode.unrestricted,  // Enable unrestricted JavaScript
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;  // Initialize the WebView controller
        },
      ),
    );
  }
}
