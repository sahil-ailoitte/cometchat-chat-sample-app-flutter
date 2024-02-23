import 'package:cometchat_sdk/cometchat_sdk.dart';

class ConnectionListener implements EventHandler{
  void onConnected() {}
  void onConnecting() {}
  void onDisconnected() {}
  void onFeatureThrottled() {}
  void onConnectionError(CometChatException error) {}
}