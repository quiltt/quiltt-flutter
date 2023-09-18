# Quiltt Connector Flutter SDK

## Usage

```dart
class _Example extends State {
  
  showQuilttConnector() {
    Configuration configuration = Configuration(
        connectorId: "connector_id",
        sessionToken: "session_token");

    QuilttConnector quilttConnector = QuilttConnector(configuration);
    quilttConnector.launch(context, (Result result) {
      // handle result
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```
