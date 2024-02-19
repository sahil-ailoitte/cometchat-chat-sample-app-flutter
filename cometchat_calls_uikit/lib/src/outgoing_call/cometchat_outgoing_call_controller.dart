import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as kit;


/// [CometChatOutgoingCallController] is the view model class for [CometChatOutgoingCall]
class CometChatOutgoingCallController extends GetxController
    with CometChatCallEventListener , CallListener {

  ///[onError] is called when some error occurs
  final OnError? onError;

  late String _listenerId;
  final Call activeCall;
  late BuildContext context;

  ///[onDeclineCallTap] is used to define the callback for the widget when decline call button is tapped.
  final Function(BuildContext, Call)? onDeclineCallTap;

  ///[disableSoundForCalls] is used to define whether to disable sound for call or not.
  final bool? disableSoundForCalls;

  ///[customSoundForCalls] is used to define the custom sound for calls.
  final String? customSoundForCalls;

  ///[customSoundForCallsPackage] is used to define the custom sound for calls.
  final String? customSoundForCallsPackage;

  ///[ongoingCallConfiguration] is used to define the configuration for ongoing call screen.
  final OngoingCallConfiguration? ongoingCallConfiguration;

  late CometChatTheme _theme;

  CometChatOutgoingCallController(
      {
      this.onError,
      required this.activeCall,
      this.onDeclineCallTap,
      CometChatTheme? theme,
        this.disableSoundForCalls,
        this.customSoundForCalls,
        this.customSoundForCallsPackage,
        this.ongoingCallConfiguration
      }){
        _theme = theme ?? cometChatTheme;
      }


  @override
  void onInit() {
    _listenerId =
        "outgoingCall${DateTime.now().microsecondsSinceEpoch.toString()}";
    addListeners();

   if(disableSoundForCalls!=true){
     playOutgoingSound();
   }

    super.onInit();
  }

  playOutgoingSound() {
    try {
    CometChatUIKit.soundManager.play(
        sound: Sound.outgoingCall, packageName: customSoundForCallsPackage ?? UIConstants.packageName, customSound: customSoundForCalls);
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

  @override
  void onClose() {
    removeListeners();
    if(disableSoundForCalls!=true){
      stopSound();
    }
    super.onClose();
    developer.log('executed on close in CometChatOutgoingCallController');
  }

  void rejectCall(BuildContext context) {
    if (onDeclineCallTap != null) {
      onDeclineCallTap!(context, activeCall);
    } else {
      if (activeCall.sessionId != null) {
        CometChatUIKitCalls.rejectCall(
            activeCall.sessionId!, CallStatusConstants.cancelled,
            onSuccess: (Call call) {
          call.category = MessageCategoryConstants.call;
          CometChatCallEvents.ccCallRejected(call);

          developer.log('call was cancelled');
          Navigator.pop(context);
        }, onError: (e) {
          try {
            if (onError != null) {
              onError!(e);
            } else {
              _showError(context, e);
            }

            Navigator.pop(context);
          } catch (err) {
            if (kDebugMode) {
              debugPrint('Error in rejecting call: ${e.message}');
            }
          }
        });
      }
    }
  }

  void addListeners() {
    CometChat.addCallListener(_listenerId, this);
    CometChatCallEvents.addCallEventsListener(_listenerId, this);
  }

  void removeListeners() {
    CometChat.removeCallListener(_listenerId);
    CometChatCallEvents.removeCallEventsListener(_listenerId);
  }

  @override
  void onOutgoingCallAccepted(Call call) {
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
            sessionId: call.sessionId!,
              callWorkFlow: CallWorkFlow.defaultCalling,
            onError: ongoingCallConfiguration?.onError,
          ),
        ));

    developer.log('outgoing call was accepted');
  }

  @override
  void onOutgoingCallRejected(Call call) {
    Navigator.pop(context);
    developer.log('outgoing call was rejected');
  }

  void _showError(BuildContext context, CometChatException e) {
      String errorMessage = e.message ?? kit.Translations.of(context).something_went_wrong_error;

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
}
