class ConnectorSDKCallbackMetadata {
  String connectorId;
  String? connectionId;
  String? moveId;
  String? profileId;

  ConnectorSDKCallbackMetadata({
    required this.connectorId,
    this.connectionId,
    this.moveId,
    this.profileId,
  });
}

class ConnectorSDKOnEventCallback {
  String type;
  ConnectorSDKCallbackMetadata eventMetadata;

  ConnectorSDKOnEventCallback({
    required this.type,
    required this.eventMetadata,
  });
}

class ConnectorSDKOnEventExitCallback {
  String type;
  ConnectorSDKCallbackMetadata eventMetadata;

  ConnectorSDKOnEventExitCallback({
    required this.type,
    required this.eventMetadata,
  });
}

class ConnectorSDKOnExitSuccessCallback {
  ConnectorSDKCallbackMetadata eventMetadata;

  ConnectorSDKOnExitSuccessCallback({
    required this.eventMetadata,
  });
}

class ConnectorSDKOnExitAbortCallback {
  ConnectorSDKCallbackMetadata eventMetadata;

  ConnectorSDKOnExitAbortCallback({
    required this.eventMetadata,
  });
}

class ConnectorSDKOnExitErrorCallback {
  ConnectorSDKCallbackMetadata eventMetadata;

  ConnectorSDKOnExitErrorCallback({
    required this.eventMetadata,
  });
}
