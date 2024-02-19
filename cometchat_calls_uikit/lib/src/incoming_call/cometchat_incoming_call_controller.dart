import 'package:flutter/foundation.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as kit;

/// [CometChatIncomingCallController] is the view model class for [CometChatIncomingCall]
class CometChatIncomingCallController extends GetxController with CallListener {
  late BuildContext context;

  late String _listenerId;

  ///[onDecline] is called when the call is declined
  final Function(BuildContext, Call)? onDecline;

  ///[onAccept] is called when the call is accepted
  final Function(BuildContext, Call)? onAccept;

  ///[disableSoundForCalls] is used to define whether to disable sound for call or not.
  final bool? disableSoundForCalls;

  ///[customSoundForCalls] is used to define the custom sound for calls.
  final String? customSoundForCalls;

  ///[customSoundForCallsPackage] is used to define the custom sound for calls.
  final String? customSoundForCallsPackage;

  ///[ongoingCallConfiguration] is used to define the configuration for ongoing call screen.
  final OngoingCallConfiguration? ongoingCallConfiguration;

  final Call activeCall;

  ///[onError] is called when some error occurs
  final OnError? onError;

  late CometChatTheme _theme;

  CometChatIncomingCallController(
      {this.onDecline,
      this.onAccept,
      required this.activeCall,
      this.onError,
      CometChatTheme? theme,
      this.disableSoundForCalls,
      this.customSoundForCalls,
      this.customSoundForCallsPackage,
      this.ongoingCallConfiguration
      }) {
    _theme = theme ?? cometChatTheme;
  }

  @override
  void onInit() {
    super.onInit();
    _listenerId =
        "incomingCall_${DateTime.now().microsecondsSinceEpoch.toString()}";
    CometChat.addCallListener(_listenerId, this);
    if (disableSoundForCalls != true) {
      playIncomingSound();
    }
  }

  @override
  void onClose() {
    CometChat.removeCallListener(_listenerId);
    if (disableSoundForCalls != true) {
      stopSound();
    }
    super.onClose();
  }

  playIncomingSound() {
    try {
      CometChatUIKit.soundManager.play(
          sound: Sound.incomingCall,
          packageName: customSoundForCallsPackage ?? UIConstants.packageName,
          customSound: customSoundForCalls);
      developer.log('sound playing');
    } catch (_) {
      developer.log("Sound not played");
    }
  }

  stopSound() {
    try {
      CometChatUIKit.soundManager.stop();
    } catch (_) {
      developer.log('failed to stop sound player');
    }
  }

  ///[acceptCall] is the method to accept a call.
  acceptCall(BuildContext context) {
    //executing custom onAccept method
    try {
      if (onAccept != null) {
        onAccept!(context, activeCall);
      }
    } on CometChatException catch (error) {
      if (onError != null) {
        onError!(error);
      } else {
        _showError(context, error);
      }
    }

    String? sessionId = activeCall.sessionId;
    if (sessionId == null) {
      return;
    }
    CometChat.acceptCall(sessionId, onSuccess: (Call call) async {
      CometChatCallEvents.ccCallAccepted(call);
      MainVideoContainerSetting? videoSettings;
      bool? isAudioOnly;

      if (call.type == CallTypeConstants.videoCall) {
        videoSettings = MainVideoContainerSetting();
        videoSettings.setMainVideoAspectRatio("contain");
        videoSettings.setNameLabelParams("top-left", true, "#000");
        videoSettings.setZoomButtonParams("top-right", true);
        videoSettings.setUserListButtonParams("top-left", true);
        videoSettings.setFullScreenButtonParams("top-right", true);
      } else {
        isAudioOnly = true;
      }

      CallSettingsBuilder callSettingsBuilder = (CallSettingsBuilder()
        ..enableDefaultLayout = true
        ..setMainVideoContainerSetting = videoSettings
        ..setAudioOnlyCall = isAudioOnly);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CometChatOngoingCall(
              callSettingsBuilder: ongoingCallConfiguration?.callSettingsBuilder ?? callSettingsBuilder,
              sessionId: sessionId,
                callWorkFlow: CallWorkFlow.defaultCalling,
              onError: ongoingCallConfiguration?.onError,
            ),
          ));

      if (kDebugMode) {
        debugPrint('call has been accepted successfully');
      }
    }, onError: (CometChatException e) {
      if (onError != null) {
        onError!(e);
      } else {
        _showError(context, e);
      }
      if (kDebugMode) {
        debugPrint('call could not be accepted ${e.message}');
      }
    });
  }

  void rejectCall(BuildContext context) {
    //executing custom onDecline method
    try {
      if (onDecline != null) {
        onDecline!(context, activeCall);
      }
    } on CometChatException catch (error) {
      if (onError != null) {
        onError!(error);
      } else {
        _showError(context, error);
      }
    }

    if (activeCall.sessionId != null) {
      developer.log("trying to reject call ");
      CometChatUIKitCalls.rejectCall(
          activeCall.sessionId!, CallStatusConstants.rejected,
          onSuccess: (Call call) {
        call.category = MessageCategoryConstants.call;
        CometChatCallEvents.ccCallRejected(call);
        developer.log('incoming call was cancelled');

        // rejectCall.setValue(call);
        Navigator.pop(context);
      }, onError: (e) {
        developer.log("Unable to end call from incoming call screen");
        try {
          if (onError != null) {
            onError!(e);
          }
        } catch (err) {
          if (kDebugMode) {
            debugPrint('Error in rejecting call: ${e.message}');
          }
        }
      });
    }
  }

  @override
  void onIncomingCallCancelled(Call call) {
    Navigator.pop(context);
  }

  void _showError(BuildContext context, CometChatException e) {
      String errorMessage =
          e.message ?? kit.Translations.of(context).something_went_wrong_error;

      showCometChatConfirmDialog(
          context: context,
          cancelButtonText: kit.Translations.of(context).cancel_capital,
          onCancel: () => Navigator.of(context).pop(),
          confirmButtonText: kit.Translations.of(context).try_again,
          messageText: Text(errorMessage,
              style: TextStyle(
                  fontSize: _theme.typography.text2.fontSize,
                  fontWeight: _theme.typography.text2.fontWeight,
                  color: _theme.palette.getAccent800())),
          style: ConfirmDialogStyle(
              backgroundColor: _theme.palette.mode == PaletteThemeModes.light
                  ? _theme.palette.getBackground()
                  : Color.alphaBlend(_theme.palette.getAccent200(),
                      _theme.palette.getBackground()),
              shadowColor: _theme.palette.getAccent300(),
              confirmButtonTextStyle: TextStyle(
                  fontSize: _theme.typography.text2.fontSize,
                  fontWeight: _theme.typography.text2.fontWeight,
                  color: _theme.palette.getPrimary()),
              cancelButtonTextStyle: TextStyle(
                  fontSize: _theme.typography.text2.fontSize,
                  fontWeight: _theme.typography.text2.fontWeight,
                  color: _theme.palette.getPrimary())));

  }

  String getSubtitle(BuildContext context){
    return activeCall.type == CallTypeConstants.audioCall ? kit.Translations.of(context).incoming_audio_call:  kit.Translations.of(context).incoming_video_call ;
  }
}
