import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../builder/presentation_settings.dart';
import '../builder/call_app_settings_request.dart';
import '../builder/call_settings.dart';
import '../helper/cometchatcalls_exception.dart';
import '../model/call_log.dart';
import '../model/generate_token.dart';
import 'cometchatcalls_plugin_method_channel.dart';

abstract class CometchatcallsPluginPlatform extends PlatformInterface {
  CometchatcallsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static CometchatcallsPluginPlatform _instance = MethodChannelCometchatcallsPlugin();

  static CometchatcallsPluginPlatform get instance => _instance;

  static set instance(CometchatcallsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void initCometChatCalls(
      CallAppSettings callAppSettings,
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('initCometChatCalls has not been implemented.');
  }

  Future<bool> isInitialized() {
    throw UnimplementedError('isInitialized has not been implemented.');
  }

  void generateToken(
      String sessionId,
      String userAuthToken,
      Function(GenerateToken generateToken) onSuccess,
      Function(CometChatCallsException error) onError
  ) {
    throw UnimplementedError('generateToken has not been implemented.');
  }

  Future<Widget?> startSession(
      String callToken,
      CallSettings callSettings,
      Function(Widget callWidget) onSuccess,
      Function(CometChatCallsException error) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  Future<Widget?> joinPresentation(
      String callToken,
      PresentationSettings presentationSettings,
      Function(Widget callWidget) onSuccess,
      Function(CometChatCallsException error) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  Future<bool> setUpNativeStreamListener(
      String callToken,
      CallSettings callSettings,
      PresentationSettings presentationSettings,
      Function(Widget callWidget) onSuccess,
      Function(CometChatCallsException error) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void endSession(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void switchCamera(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void muteAudio(
      bool muteAudio,
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void pauseVideo(
      bool pauseVideo,
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void setAudioMode(
      String setAudioMode,
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void enterPIPMode(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void exitPIPMode(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void switchToVideoCall(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void startRecording(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void stopRecording(
      Function(String success) onSuccess,
      Function(CometChatCallsException e) onError
  ) {
    throw UnimplementedError('startSession has not been implemented.');
  }

  void getCallDetails(
      String sessionId,
      String userAuthToken,
      Function(CallLog callLog) onSuccess,
      Function(CometChatCallsException error) onError
  ) {
    throw UnimplementedError('getCallDetails has not been implemented.');
  }
}
