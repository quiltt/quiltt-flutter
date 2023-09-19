library quiltt_connector;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
  late Function(Result result) _success;
  late Configuration _config;
  BuildContext? _context;

  _init(Configuration config, Function(Result result) success,
      BuildContext context) {
    _success = success;
    _config = config;
    _context = context;
  }

  _closeWebView() {
    if (_context != null && Navigator.canPop(_context!)) {
      Navigator.pop(_context!);
    }
  }

  _handleQuilttConnectorEvent(Uri uri) async {
    switch (uri.host) {
      case "oauthrequested":
        var oauthUrl = Uri.decodeFull(uri.queryParameters['oauthUrl']!);
        await launchUrlString(oauthUrl, mode: LaunchMode.externalApplication);
        break;
      case "exitsuccess":
        _success(Result(uri.queryParameters['connectionId']));
        _closeWebView();
      case "exitabort":
      case "exiterror":
        _closeWebView();
      default:
        debugPrint("Unknown event: ${uri.host}");
    }
  }

  _encodeUrl(String url) {
    return Uri.encodeComponent(url);
  }

  Widget build(BuildContext context) {
    var connectorUrl =
        "https://${_config.connectorId}.quiltt.dev/?mode=webview";
    dynamic oauthRedirectUrl = _config.oauthRedirectUrl == null
        ? null
        : _encodeUrl(_config.oauthRedirectUrl!);
    var javaScript = """
      const options = {
        source: 'quiltt',
        type: 'Options',
        token: '${_config.sessionToken}',
        connectorId: '${_config.connectorId}',
        oauthRedirectUrl: '$oauthRedirectUrl',
      };
      const compactedOptions = Object.keys(options).reduce((acc, key) => {
        if (options[key] !== 'null') {
          acc[key] = options[key];
        }
        return acc;
      }, {});
      window.postMessage(compactedOptions);
     """;
    WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller.runJavaScript(javaScript);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            Uri uri = Uri.parse(request.url);

            if (uri.scheme == "quilttconnector") {
              await _handleQuilttConnectorEvent(uri);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(connectorUrl));

    return Scaffold(
        body: SafeArea(child: WebViewWidget(controller: controller)));
  }
}

class Configuration {
  String connectorId;
  String? sessionToken;
  String? oauthRedirectUrl;

  Configuration({
    required this.connectorId,
    this.sessionToken,
    this.oauthRedirectUrl,
  });
}

class Result {
  String? connectionId;

  Result(this.connectionId);
}
