import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../cometchat_calls_sdk.dart';
import '../helper/api_connection.dart';
import '../helper/cometchatcalls_utils.dart';
import 'cometchatcalls_plugin_platform_interface.dart';

/// An implementation of [CometchatcallsPluginPlatform] that uses method channels.
class MethodChannelCometchatcallsPlugin extends CometchatcallsPluginPlatform {
  final String tag = "MethodChannelCometchatcallsPlugin";
  bool isSDKInitialized = false;

  CallSettings? callSettings;
  PresentationSettings? presentationSettings;
  CometChatCallsEventsListener? globalCallListener;
  Stream? nativeStream;
  EventChannel callsEventsStreamChannel = const EventChannel('cometchatcalls_events_stream');
  Map<String, dynamic> creationParams = <String, dynamic>{};

  @visibleForTesting
  final methodChannel = const MethodChannel('cometchatcalls_plugin');

  @override
  void initCometChatCalls(callAppSettings, onSuccess, onError) async {
    try{
      CometChatCallsUtils.showLog(tag, "initCometChatCalls: CALLED");
      if(callAppSettings.appId == null){
        onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, "App ID is null, please set the App Id first", "App ID is null, please set the App Id first"));
      }else if(callAppSettings.region == null){
        onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, "Region is null, please set the region first", "App ID is null, please set the App Id first"));
      }else{
        final result = await methodChannel.invokeMethod<Map>('initCometChatCalls', {
          "appID": callAppSettings.appId,
          "region": callAppSettings.region,
          "host": callAppSettings.host
        });
        CometChatCallsUtils.showLog(tag, "initCometChatCalls: RESULT: $result");
        if (result == null) {
          onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, "CometChatCalls SDK is not initialized, requested result is null", "CometChatCalls SDK is not initialized, requested result is null"));
        }else{
          ApiConnection.callAppSettings = callAppSettings;
          isSDKInitialized = true;
          onSuccess(result["message"]);
        }
      }
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  Future<bool> isInitialized() async {
    return isSDKInitialized;
  }

  @override
  void generateToken(sessionId, userAuthToken, onSuccess, onError) async {
    CometChatCallsUtils.showLog(tag, "generateToken: CALLED");
    try{
      if(sessionId.isEmpty){
        onError(CometChatCallsException(CometChatCallsConstants.codeSessionIdNull, "Session ID is null", "Session ID is null"));
      }else if(userAuthToken.isEmpty){
        onError(CometChatCallsException(CometChatCallsConstants.codeUserAuthTokenNull, "User auth token is null", "User auth token is null"));
      }else if(ApiConnection.callAppSettings == null){
        onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, "CometChatCalls SDK is not initialized", "CometChatCalls SDK is not initialized, please call CometChatCall.init() first"));
      }else{
        /*final result = await methodChannel.invokeMethod<Map>('generateToken', {
          "sessionId": sessionId,
          "userAuthToken": userAuthToken
        });
        CometChatCallsUtils.showLog(tag, "generateToken: RESULT: $result");
        if (result == null) {
          onError(CometChatCallsException(CometChatCallsConstants.COMETCHATCALLS_SDK_INIT_ERROR, "CometChatCalls SDK is not initialized, requested result is null", "CometChatCalls SDK is not initialized, requested result is null"));
        }else{
          final GenerateToken generateToken = GenerateToken.fromMap(result);
          onSuccess(generateToken);
        }*/
        ApiConnection().generateToken(GenerateToken(sessionId: sessionId), userAuthToken, (String response){
          final obj = GenerateToken.fromJson(jsonDecode(response)["data"]);
          onSuccess(obj);
        }, (CometChatCallsException e){
          CometChatCallsUtils.showLog(tag, "generateToken onError: ${e.message}");
          onError(e);
        });
      }
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  Future<Widget?> startSession(String callToken, CallSettings callSettings, onSuccess, onError) async{
    try{
      if(callToken.isNotEmpty){
        await setUpNativeStreamListener(callToken, callSettings, null, onSuccess, onError);
        await getCometChatCallingView(callToken, callSettings, null);
        if (Platform.isAndroid){
          final nativeView = PlatformViewLink(
              viewType: "cometchatcallsNativeViewAndroid",
              surfaceFactory: (context, controller) {
                return AndroidViewSurface(
                    controller: controller as AndroidViewController,
                    hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                );
              },
              onCreatePlatformView: (params){
                return PlatformViewsService.initExpensiveAndroidView(
                    id: params.id,
                    viewType: "cometchatcallsNativeViewAndroid",
                    layoutDirection: TextDirection.ltr
                )
                  ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                  ..create();
              },
          );
          onSuccess(nativeView);
          return nativeView;
        }else {
          final Map<String, dynamic> creationParams = <String, dynamic>{};
          final nativeView = UiKitView(
            viewType: "cometchatcallsNativeViewiOS",
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          );
          onSuccess(nativeView);
          return nativeView;
        }
      }else{
        onError(CometChatCallsException(CometChatCallsConstants.codeError, "Call token is null", "Call token is null"));
      }
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
    return null;
  }

  @override
  Future<Widget?> joinPresentation(String callToken, PresentationSettings presentationSettings, onSuccess, onError) async{
    try{
      if(callToken.isNotEmpty){
        await setUpNativeStreamListener(callToken, null, presentationSettings, onSuccess, onError);
        await getCometChatCallingView(callToken, null, presentationSettings);
        if (Platform.isAndroid){
          final nativeView = PlatformViewLink(
              viewType: "cometchatcallsNativeViewAndroid",
              surfaceFactory: (context, controller) {
                return AndroidViewSurface(
                    controller: controller as AndroidViewController,
                    hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                );
              },
              onCreatePlatformView: (params){
                return PlatformViewsService.initExpensiveAndroidView(
                    id: params.id,
                    viewType: "cometchatcallsNativeViewAndroid",
                    layoutDirection: TextDirection.ltr
                )
                  ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                  ..create();
              },
          );
          onSuccess(nativeView);
          return nativeView;
        }else {
          final Map<String, dynamic> creationParams = <String, dynamic>{};
          final nativeView = UiKitView(
            viewType: "cometchatcallsNativeViewiOS",
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          );
          onSuccess(nativeView);
          return nativeView;
        }
      }else{
        onError(CometChatCallsException(CometChatCallsConstants.codeError, "Call token is null", "Call token is null"));
      }
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
    return null;
  }

  Future<Map<dynamic, dynamic>> getCometChatCallingView(String callToken, CallSettings? callSettings, PresentationSettings? presentationSettings) async {
    if(presentationSettings != null){
      final result = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('joinPresentation', {
        "callToken": callToken,
        "defaultLayout" : presentationSettings.defaultLayout,
        "isAudioOnly" : presentationSettings.isAudioOnly,
        "isSingleMode" : presentationSettings.isSingleMode,
        "endCallButtonDisable" : presentationSettings.endCallButtonDisable,
        "showRecordingButton" : presentationSettings.showRecordingButton,
        "switchCameraButtonDisable" : presentationSettings.switchCameraButtonDisable,
        "muteAudioButtonDisable" : presentationSettings.muteAudioButtonDisable,
        "pauseVideoButtonDisable" : presentationSettings.pauseVideoButtonDisable,
        "audioModeButtonDisable" : presentationSettings.audioModeButtonDisable,
        "startAudioMuted" : presentationSettings.startAudioMuted,
        "startVideoMuted" : presentationSettings.startVideoMuted,
        "isPresenter" : presentationSettings.isPresenter,
        "defaultAudioMode" : presentationSettings.defaultAudioMode,
      });
      return result!;
    }else {
      String? videoFit;

      String? fullScreenButtonPosition;
      bool? fullScreenButtonVisibility;

      String? userListButtonPosition;
      bool? userListButtonVisibility;

      String? zoomButtonPosition;
      bool? zoomButtonVisibility;

      String? nameLabelPosition;
      bool? nameLabelVisibility;
      String? nameLabelColor;

      if(callSettings!.videoSettings != null){
        videoFit = callSettings.videoSettings!.videoFit;
        if(callSettings.videoSettings!.fullScreenButton != null){
          fullScreenButtonPosition = callSettings.videoSettings!.fullScreenButton!.position;
          fullScreenButtonVisibility = callSettings.videoSettings!.fullScreenButton!.visibility;
        }
        if(callSettings.videoSettings!.userListButton != null){
          userListButtonPosition = callSettings.videoSettings!.userListButton!.position;
          userListButtonVisibility = callSettings.videoSettings!.userListButton!.visibility;
        }
        if(callSettings.videoSettings!.zoomButton != null){
          zoomButtonPosition = callSettings.videoSettings!.zoomButton!.position;
          zoomButtonVisibility = callSettings.videoSettings!.zoomButton!.visibility;
        }
        if(callSettings.videoSettings!.nameLabel != null){
          nameLabelPosition = callSettings.videoSettings!.nameLabel!.position;
          nameLabelVisibility = callSettings.videoSettings!.nameLabel!.visibility;
          nameLabelColor = callSettings.videoSettings!.nameLabel!.color;
        }
      }

      final result = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('startSession', {
        "callToken": callToken,
        "defaultLayout" : callSettings.defaultLayout,
        "isAudioOnly" : callSettings.isAudioOnly,
        "isSingleMode" : callSettings.isSingleMode,
        "showSwitchToVideoCall" : callSettings.showSwitchToVideoCall,
        "enableVideoTileClick" : callSettings.enableVideoTileClick,
        "enableDraggableVideoTile" : callSettings.enableDraggableVideoTile,
        "endCallButtonDisable" : callSettings.endCallButtonDisable,
        "showRecordingButton" : callSettings.showRecordingButton,
        "startRecordingOnCallStart" : callSettings.startRecordingOnCallStart,
        "switchCameraButtonDisable" : callSettings.switchCameraButtonDisable,
        "muteAudioButtonDisable" : callSettings.muteAudioButtonDisable,
        "pauseVideoButtonDisable" : callSettings.pauseVideoButtonDisable,
        "audioModeButtonDisable" : callSettings.audioModeButtonDisable,
        "startAudioMuted" : callSettings.startAudioMuted,
        "startVideoMuted" : callSettings.startVideoMuted,
        "avatarMode" : callSettings.avatarMode,
        "mode" : callSettings.mode,
        "defaultAudioMode" : callSettings.defaultAudioMode,

        "videoFit" : videoFit,

        "fullScreenButtonPosition" : fullScreenButtonPosition,
        "fullScreenButtonVisibility" : fullScreenButtonVisibility,

        "userListButtonPosition" : userListButtonPosition,
        "userListButtonVisibility" : userListButtonVisibility,

        "zoomButtonPosition" : zoomButtonPosition,
        "zoomButtonVisibility" : zoomButtonVisibility,

        "nameLabelPosition" : nameLabelPosition,
        "nameLabelVisibility" : nameLabelVisibility,
        "nameLabelColor" : nameLabelColor,
      });
      return result!;
    }
  }

  @override
  Future<bool> setUpNativeStreamListener(String callToken, CallSettings? callSettings, PresentationSettings? presentationSettings, onSuccess, onError) async {
    try{
      if(nativeStream == null){
        this.callSettings = callSettings;
        this.presentationSettings = presentationSettings;
        globalCallListener = (callSettings == null) ? presentationSettings?.listener : callSettings.listener;
        initializeCallsEventStream();
        nativeStream?.listen((event) {
          CometChatCallsUtils.showLog("CometChatCall", "nativeStream: value: ${event.toString()}");
        });
        return true;
      }else{
        this.callSettings = callSettings;
        this.presentationSettings = presentationSettings;
        globalCallListener = (callSettings == null) ? presentationSettings?.listener : callSettings.listener;
        return true;
      }
    }catch(e){
      CometChatCallsUtils.showLog("CometChatCall", "startSession: error: ${e.toString()}");
      onError(CometChatCallsException(CometChatCallsConstants.codeError, "Unable to start call session", e.toString()));
    }
    return false;
  }

  void initializeCallsEventStream() {
    nativeStream = callsEventsStreamChannel.receiveBroadcastStream(1).map((e) {
      CometChatCallsUtils.showLog("CometChatCall", "eventStream: methodNameReceived: ${e["methodName"]}");
      CometChatCallsUtils.showLog("CometChatCall", "eventStream: globalCallListener: $globalCallListener");
      if(globalCallListener != null){
        switch (e["methodName"]) {
          case "onCallEnded":
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onCallEnded");
            globalCallListener?.onCallEnded();
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onCallEnded();
            }
            break;
          case "onCallEndButtonPressed":
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onCallEndButtonPressed");
            globalCallListener?.onCallEndButtonPressed();
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onCallEndButtonPressed();
            }
            break;
          case "onUserJoined":
            RTCUser user = RTCUser.fromMap(e);
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onUserJoined: value: ${user.toString()}");
            globalCallListener?.onUserJoined(user);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onUserJoined(user);
            }
            break;
          case "onUserLeft":
            RTCUser user = RTCUser.fromMap(e);
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onUserLeft: value: ${user.toString()}");
            globalCallListener?.onUserLeft(user);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onUserLeft(user);
            }
            break;
          case "onUserListChanged":
            List<RTCUser> userList = e["userList"].map<RTCUser>( (entry) => RTCUser.fromMap(e)).toList();
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onUserListChanged: value: ${userList.toString()}");
            globalCallListener?.onUserListChanged(userList);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onUserListChanged(userList);
            }
            break;
          case "onAudioModeChanged":
            List<AudioMode> audioModeList = e["audioModeList"].map<AudioMode>( (entry) => AudioMode.fromMap(e)).toList();
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onAudioModeChanged: value: ${audioModeList.toString()}");
            globalCallListener?.onAudioModeChanged(audioModeList);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onAudioModeChanged(audioModeList);
            }
            break;
          case "onCallSwitchedToVideo":
            CallSwitchRequestInfo info = CallSwitchRequestInfo.fromMap(e);
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onCallSwitchedToVideo: value: ${info..toString()}");
            globalCallListener?.onCallSwitchedToVideo(info);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onCallSwitchedToVideo(info);
            }
            break;
          case "onUserMuted":
            RTCMutedUser muteObj = RTCMutedUser.fromMap(e);
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onUserMuted: value: ${muteObj.toString()}");
            globalCallListener?.onUserMuted(muteObj);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onUserMuted(muteObj);
            }
            break;
          case "onRecordingToggled":
            RTCRecordingInfo info = RTCRecordingInfo.fromMap(e);
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onRecordingToggled: value: ${info.toString()}");
            globalCallListener?.onRecordingToggled(info);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onRecordingToggled(info);
            }
            break;
          case "onError":
            CometChatCallsException ce = CometChatCallsException.fromMap(e);
            CometChatCallsUtils.showLog("CometChatCall", "eventStream => onError: value: ${ce.toString()}");
            globalCallListener?.onError(ce);
            for (var element in CometChatCalls.callsEventsListener.values) {
              element.onError(ce);
            }
            break;
        }
      }
    });
  }

  @override
  void endSession(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('endSession');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void switchCamera(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('switchCamera');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void muteAudio(bool muteAudio, onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('muteAudio', {
        "flag": muteAudio,
      });
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void pauseVideo(bool pauseVideo, onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('pauseVideo', {
        "flag": pauseVideo,
      });
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void setAudioMode(String setAudioMode, onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('setAudioMode', {
        "value": setAudioMode,
      });
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void enterPIPMode(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('enterPIPMode');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void exitPIPMode(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('exitPIPMode');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void switchToVideoCall(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('switchToVideoCall');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void startRecording(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('startRecording');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void stopRecording(onSuccess, onError) async {
    try{
      final result = await methodChannel.invokeMethod<String>('stopRecording');
      onSuccess(result ?? "success");
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  @override
  void getCallDetails(sessionId, userAuthToken, onSuccess, onError) async {
    CometChatCallsUtils.showLog(tag, "getCallDetails: CALLED");
    try{
      if(sessionId.isEmpty){
        onError(CometChatCallsException(CometChatCallsConstants.codeSessionIdNull, "Session ID is null", "Session ID is null"));
      }else if(userAuthToken.isEmpty){
        onError(CometChatCallsException(CometChatCallsConstants.codeUserAuthTokenNull, "User auth token is null", "User auth token is null"));
      }else if(ApiConnection.callAppSettings == null){
        onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, "CometChatCalls SDK is not initialized", "CometChatCalls SDK is not initialized, please call CometChatCall.init() first"));
      }else{
        ApiConnection().getCallDetails(sessionId, userAuthToken, (String response){
          final obj = CallLog.fromJson(jsonDecode(response)["data"]);
          onSuccess(obj);
        }, (CometChatCallsException e){
          CometChatCallsUtils.showLog(tag, "getCallDetails onError: ${e.message}");
          onError(e);
        });
      }
    } on PlatformException catch (platformException) {
      onError(CometChatCallsException(platformException.code, platformException.message, platformException.details));
    } catch (e) {
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

}
