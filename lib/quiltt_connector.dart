library quiltt_connector;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:quiltt_connector/configuration.dart';
import 'package:quiltt_connector/event.dart';

/// This class is the entry point for the Quiltt Connector SDK.
class QuilttConnector {
  String? sessionToken;
  late String connectorId;
  late String connectionId;
  final _WebViewPage _webViewPage = _WebViewPage();
  final WebViewController controller = WebViewController();

  /// Pass token to authenticate, authenticate through UI if token is absent
  void authenticate(String token) {
    sessionToken = token;
    String javaScript = '''
      const options = {
        source: 'quiltt',
        type: 'Options',
        token: '$sessionToken',
      };
      window.postMessage(options);
     ''';
    controller.runJavaScript(javaScript);
  }

  /// Connect to a connector
  connect(
    BuildContext context,
    QuilttConnectorConfiguration config, {
    Function(Event event)? onEvent,
    Function(Event event)? onExit,
    Function(Event event)? onExitSuccess,
    Function(Event event)? onExitAbort,
    Function(Event event)? onExitError,
  }) {
    connectorId = config.connectorId;
    _webViewPage._init(controller, context, config,
        token: sessionToken,
        onEvent: onEvent,
        onExit: onExit,
        onExitSuccess: onExitSuccess,
        onExitAbort: onExitAbort,
        onExitError: onExitError);

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return _webViewPage.build(context, token: sessionToken);
    }));
  }

  /// Reconnect to a connector
  reconnect(
    BuildContext context,
    QuilttConnectorConfiguration config, {
    Function(Event event)? onEvent,
    Function(Event event)? onExit,
    Function(Event event)? onExitSuccess,
    Function(Event event)? onExitAbort,
    Function(Event event)? onExitError,
  }) {
    connectorId = config.connectorId;
    connectionId = config.connectionId!;
    _webViewPage._init(controller, context, config,
        token: sessionToken,
        onEvent: onEvent,
        onExit: onExit,
        onExitSuccess: onExitSuccess,
        onExitAbort: onExitAbort,
        onExitError: onExitError);

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return _webViewPage.build(context,
          token: sessionToken, connectionId: config.connectionId);
    }));
  }
}

class _WebViewPage {
  late WebViewController controller;
  late BuildContext context;
  late QuilttConnectorConfiguration config;
  String? token;
  Function(Event event)? onEvent;
  Function(Event event)? onExit;
  Function(Event event)? onExitSuccess;
  Function(Event event)? onExitAbort;
  Function(Event event)? onExitError;

  _init(controller, context, QuilttConnectorConfiguration config,
      {String? token,
      Function(Event event)? onEvent,
      Function(Event event)? onExit,
      Function(Event event)? onExitSuccess,
      Function(Event event)? onExitAbort,
      Function(Event event)? onExitError}) {
    this.controller = controller;
    this.context = context;
    this.token = token;
    this.config = config;
    this.onEvent = onEvent;
    this.onExit = onExit;
    this.onExitSuccess = onExitSuccess;
    this.onExitAbort = onExitAbort;
    this.onExitError = onExitError;
  }

  _closeWebView() {
    if (Navigator.canPop(context)) {
      controller.clearLocalStorage();
      Navigator.pop(context);
    }
  }

  final _shouldRenderList = [
    'quiltt.app',
    'quiltt.dev',
    'moneydesktop.com',
    'cdn.plaid.com/link/v2/stable/link.html',
  ];

  _shouldRender(String url) {
    for (var host in _shouldRenderList) {
      if (url.contains(host)) {
        return true;
      }
    }
    return false;
  }

  _handleOAuth(String oauthUrl) async {
    await launchUrlString(oauthUrl, mode: LaunchMode.externalApplication);
  }

  _handleQuilttConnectorEvent(Uri uri, String initInjectedJavaScript) async {
    EventMetadata eventMetadata = EventMetadata(
      connectorId: config.connectorId,
      connectionId: uri.queryParameters['connectionId'],
      moveId: uri.queryParameters['moveId'],
    );
    String eventType = uri.host;
    switch (uri.host) {
      case 'load':
        controller.runJavaScript(initInjectedJavaScript);
        break;
      case 'oauthrequested':
        var oauthUrl = Uri.decodeFull(uri.queryParameters['oauthUrl']!);
        await _handleOAuth(oauthUrl);
        break;
      case 'exitsuccess':
        onExit?.call(Event(type: eventType, eventMetadata: eventMetadata));
        onExitSuccess
            ?.call(Event(type: eventType, eventMetadata: eventMetadata));
        _closeWebView();
        break;
      case 'exitabort':
        onExit?.call(Event(type: eventType, eventMetadata: eventMetadata));
        onExitAbort?.call(Event(type: eventType, eventMetadata: eventMetadata));
        _closeWebView();
        break;
      case 'exiterror':
        onExit?.call(Event(type: eventType, eventMetadata: eventMetadata));
        onExitAbort?.call(Event(type: eventType, eventMetadata: eventMetadata));
        _closeWebView();
        break;
      case 'authenticate':
        // @todo handle Authenticate
        break;
      default:
        debugPrint('Unknown event: ${uri.host}');
    }
  }

  Widget build(BuildContext context, {String? token, String? connectionId}) {
    var oauthRedirectUrl = Uri.encodeComponent(config.oauthRedirectUrl);
    var connectorUrl =
        'https://${config.connectorId}.quiltt.app/?mode=webview&oauth_redirect_url=$oauthRedirectUrl&sdk=flutter&quiltt&quiltt_debug=true';
    debugPrint(connectorUrl);
    var initInjectedJavaScript = '''
      const options = {
        source: 'quiltt',
        type: 'Options',
        token: '$token',
        connectorId: '${config.connectorId}',
        connectionId: '$connectionId',
      };
      const compactedOptions = Object.keys(options).reduce((acc, key) => {
        if (options[key] !== 'null') {
          acc[key] = options[key];
        }
        return acc;
      }, {});
      window.postMessage(compactedOptions);
     ''';

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            Uri uri = Uri.parse(request.url);

            if (uri.scheme == 'quilttconnector') {
              await _handleQuilttConnectorEvent(uri, initInjectedJavaScript);
              return NavigationDecision.prevent;
            }

            if (_shouldRender(request.url)) {
              return NavigationDecision.navigate;
            }

            await _handleOAuth(request.url);
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(connectorUrl));

    return Scaffold(
        body: SafeArea(child: WebViewWidget(controller: controller)));
  }
}
