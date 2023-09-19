library quiltt_connector;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QuilttConnector {
  late Configuration _configuration;

  QuilttConnector(Configuration configuration) {
    _configuration = configuration;
  }

  launch(BuildContext context, Function(Result result) success) {
    _WebViewPage webViewPage = _WebViewPage();
    webViewPage._init(_configuration, success, context);

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return webViewPage.build(context);
    }));
  }
}

class _WebViewPage {
  String? _connectorUrl;
  late Function(Result result) _success;
  late Configuration _config;
  BuildContext? _context;

  _init(Configuration config, Function(Result result) success,
      BuildContext context) {
    _success = success;
    _config = config;
    _context = context;
    _connectorUrl = "https://${config.connectorId}.quiltt.dev/?mode=webview";
    debugPrint("init url: $_connectorUrl");
  }

  _closeWebView() {
    if (_context != null && Navigator.canPop(_context!)) {
      Navigator.pop(_context!);
    }
  }

  _handleQuilttConnectorEvent(WebUri uri) async {
    if (uri.host == "oauthrequested") {
      var oauthUrl = Uri.decodeFull(uri.queryParameters['oauthUrl']!);

      if (await canLaunchUrlString(oauthUrl)) {
        launchUrlString(oauthUrl, mode: LaunchMode.externalApplication);
      }
    }

    if (uri.host == "exitsuccess") {
      _success(Result(uri.queryParameters['connectionId']));
      _closeWebView();
    }
  }

  Widget build(BuildContext context) {
    var webView = InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(_connectorUrl!)),
      initialSettings: InAppWebViewSettings(useShouldOverrideUrlLoading: true),
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(source: """
          const options = {
            source: 'quiltt',
            type: 'Options',
            token: '${_config.sessionToken}',
            connectorId: '${_config.connectorId}'
          };
          const compactedOptions = Object.keys(options).reduce((acc, key) => {
            if (options[key] !== 'null') {
              acc[key] = options[key];
            }
            return acc;
          }, {});
          window.postMessage(compactedOptions);
          """);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url!;

        if (["https", "http"].contains(uri.scheme) &&
            uri.host.contains("quiltt.app")) {
          return NavigationActionPolicy.ALLOW;
        }

        if (uri.scheme == "quilttconnector") {
          _handleQuilttConnectorEvent(uri);
        }
        return NavigationActionPolicy.CANCEL;
      },
    );
    return Scaffold(body: webView);
  }
}

class Configuration {
  String connectorId;
  String? sessionToken;

  Configuration({
    required this.connectorId,
    this.sessionToken,
  });
}

class Result {
  String? connectionId;

  Result(this.connectionId);
}
