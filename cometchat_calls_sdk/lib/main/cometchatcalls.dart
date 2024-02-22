/// Created by Rohit Giri on 22/03/23.
import 'dart:async';
import 'package:flutter/material.dart';

import '../model/call_log.dart';
import '../model/generate_token.dart';
import '../helper/cometchatcalls_utils.dart';
import '../builder/call_app_settings_request.dart';
import '../builder/call_settings.dart';
import '../builder/presentation_settings.dart';
import '../helper/cometchatcalls_exception.dart';
import '../interface/cometchat_calls_events_listener.dart';
import 'cometchatcalls_plugin_platform_interface.dart';

class CometChatCalls {

  static final Map<String, CometChatCallsEventsListener> callsEventsListener = {};

  ///For every activity or fragment you wish to receive calling event callbacks then you need to register the CometChatCallsEventsListener
  ///
  /// [listenerId] unique id for listener
  static addCallsEventListeners(String listenerId, CometChatCallsEventsListener listenerClass) {
    callsEventsListener[listenerId] = listenerClass;
  }

  ///To remove CometChatCallsEventsListener listener
  ///
  ///We recommend you remove the listener once the activity or fragment is not in use. Typically, this can be added in the dispose() method.
  static removeCallsEventListeners(String listenerId) {
    callsEventsListener.remove(listenerId);
  }

  /// Initializes the CometChat Calls plugin.
  ///
  /// * `callAppSettings`: The call app settings.
  /// * `onSuccess`: A callback function that is called when the plugin is successfully initialized.
  /// * `onError`: A callback function that is called when an error occurs while initializing the plugin.
  ///
  /// **Example:**
  /// CometChatCalls.init(
  ///   callAppSettings: <YOUR_CALL_APP_SETTINGS>,
  ///   onSuccess: (success) {
  ///     // The plugin was successfully initialized.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while initializing the plugin.
  ///   },
  /// );
  ///
  static void init(CallAppSettings callAppSettings, {
    required Function(String success) onSuccess,
    required Function(CometChatCallsException error) onError
  }) async {
    CometchatcallsPluginPlatform.instance.initCometChatCalls(callAppSettings, onSuccess, onError);
  }

  /// Checks if the CometChat Calls SDK is initialized.
  ///
  /// Returns a [Future] with a [bool] value indicating whether the CometChat Calls Plugin is initialized or not.
  ///
  /// Example:
  /// ```dart
  /// bool initialized = await isInitialized();
  /// if (initialized) {
  ///   // Continue with your logic
  /// } else {
  ///   // Show initialization error message
  /// }
  ///
  static Future<bool> isInitialized() async {
    return CometchatcallsPluginPlatform.instance.isInitialized();
  }

  /// Generates a call token.
  ///
  /// * `sessionId`: The session ID.
  /// * `userAuthToken`: The user auth token.
  /// * `onSuccess`: A callback function that is called when the call token is successfully generated.
  /// * `onError`: A callback function that is called when an error occurs while generating the call token.
  ///
  /// **Example:**
  /// CometChatCalls.generateToken(
  ///   sessionId: '<YOUR_SESSION_ID>',
  ///   userAuthToken: '<YOUR_USER_AUTH_TOKEN>',
  ///   onSuccess: (generateToken) {
  ///     // The call token was successfully generated.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while generating the call token.
  ///   },
  /// );
  ///
  static void generateToken(String sessionId, String userAuthToken, {
    required Function(GenerateToken generateToken) onSuccess,
    required Function(CometChatCallsException error) onError
  }) async {
    CometchatcallsPluginPlatform.instance.generateToken(sessionId, userAuthToken, onSuccess, onError);
  }

  /// Starts a call session.
  ///
  /// * `callToken`: The call token.
  /// * `callSettings`: The call settings.
  /// * `onSuccess`: A callback function that is called when the call session is successfully started.
  /// * `onError`: A callback function that is called when an error occurs while starting the call session.
  ///
  /// **Example:**
  /// CometChatCalls.startSession(
  ///   callToken: '<YOUR_CALL_TOKEN>',
  ///   callSettings: <YOUR_CALL_SETTINGS>,
  ///   onSuccess: (callingWidget) {
  ///     // The call session was successfully started.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while starting the call session.
  ///   },
  /// );
  ///
  static Future<Widget?>? startSession(String callToken, CallSettings callSettings, {
    required Function(Widget? callingWidget) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) async{
    try{
      final callingViewWidget = await CometchatcallsPluginPlatform.instance.startSession(callToken, callSettings, onSuccess, onError);
      return callingViewWidget;
    }catch(e){
      CometChatCallsUtils.showLog("CometChatCall", "startSession: error: ${e.toString()}");
      onError(CometChatCallsException("Error", "Unable to start call session", e.toString()));
    }
    return null;
  }

  /// Join Presentation mode.
  ///
  /// * `callToken`: The call token.
  /// * `callSettings`: The call settings.
  /// * `onSuccess`: A callback function that is called when the call session is successfully started.
  /// * `onError`: A callback function that is called when an error occurs while starting the call session.
  ///
  /// **Example:**
  /// CometChatCalls.startSession(
  ///   callToken: '<YOUR_CALL_TOKEN>',
  ///   callSettings: <YOUR_CALL_SETTINGS>,
  ///   onSuccess: (callingWidget) {
  ///     // The call session was successfully started.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while starting the call session.
  ///   },
  /// );
  ///
  static Future<Widget?>? joinPresentation(String callToken, PresentationSettings presentationSettings, {
    required Function(Widget? callingWidget) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) async{
    try{
      final callingViewWidget = await CometchatcallsPluginPlatform.instance.joinPresentation(callToken, presentationSettings, onSuccess, onError);
      return callingViewWidget;
    }catch(e){
      CometChatCallsUtils.showLog("CometChatCall", "startSession: error: ${e.toString()}");
      onError(CometChatCallsException("Error", "Unable to start call session", e.toString()));
    }
    return null;
  }

  /// Ends the session.
  ///
  /// * `onSuccess`: A callback function that is called when the session is successfully ended.
  /// * `onError`: A callback function that is called when an error occurs while ending the session.
  ///
  /// **Example:**
  /// CometChatCalls.endSession(
  ///   onSuccess: (message) {
  ///     // The session was successfully ended.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while ending the session.
  ///   },
  /// );
  ///
  static void endSession({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.endSession(onSuccess, onError);
  }

  /// Switches the camera.
  ///
  /// * `onSuccess`: A callback function that is called when the camera is successfully switched.
  /// * `onError`: A callback function that is called when an error occurs while switching the camera.
  ///
  /// **Example:**
  /// CometChatCalls.switchCamera(
  ///   onSuccess: (message) {
  ///     // The camera was successfully switched.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while switching the camera.
  ///   },
  /// );
  ///
  static void switchCamera({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.switchCamera(onSuccess, onError);
  }

  /// Mutes the audio.
  ///
  /// * `muteAudio`: Whether to mute the audio.
  /// * `onSuccess`: A callback function that is called when the audio is successfully muted.
  /// * `onError`: A callback function that is called when an error occurs while muting the audio.
  ///
  /// **Example:**
  /// CometChatCalls.muteAudio(true,
  ///   onSuccess: (message) {
  ///     // The audio was successfully muted.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while muting the audio.
  ///   },
  /// );
  ///
  static void muteAudio(bool muteAudio, {
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.muteAudio(muteAudio, onSuccess, onError);
  }

  /// Pauses the video.
  ///
  /// * `pauseVideo`: Whether to pause the video.
  /// * `onSuccess`: A callback function that is called when the video is successfully paused.
  /// * `onError`: A callback function that is called when an error occurs while pausing the video.
  ///
  /// **Example:**
  /// CometChatCalls.pauseVideo(true,
  ///   onSuccess: (message) {
  ///     // The video was successfully paused.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while pausing the video.
  ///   },
  /// );
  ///
  static void pauseVideo(bool pauseVideo, {
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.pauseVideo(pauseVideo, onSuccess, onError);
  }

  /// Sets the audio mode.
  ///
  /// * `setAudioMode`: The audio mode to set.
  /// * `onSuccess`: A callback function that is called when the audio mode is successfully set.
  /// * `onError`: A callback function that is called when an error occurs while setting the audio mode.
  ///
  /// **Example:**
  /// CometChatCalls.setAudioMode("speakerphone",
  ///   onSuccess: (message) {
  ///     // The audio mode was successfully set to "speakerphone".
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while setting the audio mode.
  ///   },
  /// );
  ///
  static void setAudioMode(String setAudioMode, {
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.setAudioMode(setAudioMode, onSuccess, onError);
  }

  /// Enters picture-in-picture mode.
  ///
  /// * `onSuccess`: A callback function that is called when the call is successfully entered into picture-in-picture mode.
  /// * `onError`: A callback function that is called when an error occurs while entering the call into picture-in-picture mode.
  ///
  /// **Example:**
  /// CometChatCalls.enterPIPMode(
  ///   onSuccess: (message) {
  ///     // The call was successfully entered into picture-in-picture mode.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while entering the call into picture-in-picture mode.
  ///   },
  /// );
  ///
  static void enterPIPMode({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.enterPIPMode(onSuccess, onError);
  }

  /// Exits picture-in-picture mode.
  ///
  /// * `onSuccess`: A callback function that is called when the call is successfully exited from picture-in-picture mode.
  /// * `onError`: A callback function that is called when an error occurs while exiting the call from picture-in-picture mode.
  ///
  /// **Example:**
  /// CometChatCalls.exitPIPMode(
  ///   onSuccess: (message) {
  ///     // The call was successfully exited from picture-in-picture mode.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while exiting the call from picture-in-picture mode.
  ///   },
  /// );
  ///
  static void exitPIPMode({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.exitPIPMode(onSuccess, onError);
  }

  /// Switches to a video call.
  ///
  /// * `onSuccess`: A callback function that is called when the switch is successfully completed.
  /// * `onError`: A callback function that is called when an error occurs while switching to the video call.
  ///
  /// **Example:**
  /// CometChatCalls.switchToVideoCall(
  ///     onSuccess: (message) {
  ///       // The recording was successfully started.
  ///     },
  ///     onError: (error) {
  ///       // An error occurred while starting the recording.
  ///     },
  ///  );
  ///
  static void switchToVideoCall({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.switchToVideoCall(onSuccess, onError);
  }

  /// Starts a new recording.
  ///
  /// * `onSuccess`: A callback function that is called when the recording is successfully started.
  /// * `onError`: A callback function that is called when an error occurs while starting the recording.
  ///
  /// **Example:**
  /// CometChatCalls.startRecording(
  ///   onSuccess: (message) {
  ///     // The recording was successfully started.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while starting the recording.
  ///   },
  /// );
  ///
  static void startRecording({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.startRecording(onSuccess, onError);
  }

  /// Stops the current recording.
  ///
  /// * `onSuccess`: A callback function that is called when the recording is successfully stopped.
  /// * `onError`: A callback function that is called when an error occurs while stopping the recording.
  ///
  /// **Example:**
  /// CometChatCalls.stopRecording(
  ///   onSuccess: (message) {
  ///     // The recording was successfully stopped.
  ///   },
  ///   onError: (error) {
  ///     // An error occurred while stopping the recording.
  ///   },
  /// );
  ///
  static void stopRecording({
    required Function(String onSuccess) onSuccess,
    required Function(CometChatCallsException excep) onError
  }) {
    CometchatcallsPluginPlatform.instance.stopRecording(onSuccess, onError);
  }

  /// Retrieves the call details for a given session ID.
  ///
  /// The [sessionId] parameter specifies the session ID for which the call details are to be retrieved.
  /// The [userAuthToken] parameter is the user authentication token required for authorization.
  /// The [onSuccess] function is called with the retrieved [CallLog] object when the call details are retrieved successfully.
  /// The [onError] function is called with a [CometChatCallsException] object when there is an error while retrieving the call details.
  ///
  /// Example:
  /// CometChatCalls.getCallDetails(
  ///   "sessionId",
  ///   "userAuthToken",
  ///   onSuccess: (callLog) {
  ///     // Process the retrieved call details
  ///   },
  ///   onError: (error) {
  ///     // Handle the error
  ///   },
  /// );
  /// ```
  static void getCallDetails(String sessionId, String userAuthToken, {
    required Function(CallLog callLog) onSuccess,
    required Function(CometChatCallsException error) onError
  }) async {
    CometchatcallsPluginPlatform.instance.getCallDetails(sessionId, userAuthToken, onSuccess, onError);
  }
}
