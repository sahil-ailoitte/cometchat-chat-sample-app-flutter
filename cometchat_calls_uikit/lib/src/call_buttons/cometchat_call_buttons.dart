import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart' as kit;
import 'package:get/get.dart';

/// [CometChatCallButtons] is a button widget with voice and video call icons.
///
/// ```dart
/// CometChatCallButtons(
///  user: user,
///  group: group,
///  voiceCallIconURL: '',
///  voiceCallIconPackage: '',
///  voiceCallIconText: '',
///  voiceCallIconHoverText: '',
///  videoCallIconURL: '',
///  videoCallIconPackage: '',
///  videoCallIconText: '',
///  videoCallIconHoverText: '',
///  onVoiceCallClick: (context) {
///  print('Voice Call');
///  },
///  onVideoCallClick: (context) {
///  print('Video Call');
///  },
///  callButtonsStyle: CallButtonsStyle(
///  borderRadius: 8,
///  color: Colors.blue,
///  ),
///  theme: cometChatTheme,
///  alignment: BubbleAlignment.left,
///  );
///  ```
///
class CometChatCallButtons extends StatelessWidget {
  /// [CometChatCallButtons] constructor requires [user], [group], [voiceCallIconURL], [voiceCallIconPackage], [voiceCallIconText], [voiceCallIconHoverText], [videoCallIconURL], [videoCallIconPackage], [videoCallIconText], [videoCallIconHoverText], [onVoiceCallClick], [onVideoCallClick], [callButtonsStyle] and [onError] while initializing.
  CometChatCallButtons(
      {Key? key,
      this.user,
      this.group,
      this.voiceCallIconURL,
      this.voiceCallIconPackage,
      this.voiceCallIconText,
      this.voiceCallIconHoverText,
      this.videoCallIconURL,
      this.videoCallIconPackage,
      this.videoCallIconText,
      this.videoCallIconHoverText,
      this.onVoiceCallClick,
      this.onVideoCallClick,
      this.callButtonsStyle,
      OnError? onError,
      OutgoingCallConfiguration? outgoingCallConfiguration,
      OngoingCallConfiguration? ongoingCallConfiguration,
      this.hideVideoCall,
      this.hideVoiceCall})
      : _callButtonsController = CometChatCallButtonsController(
            user: user,
            group: group,
            onError: onError,
            outgoingCallConfiguration: outgoingCallConfiguration,
            ongoingCallConfiguration: ongoingCallConfiguration),
        super(key: key);

  ///[user] is a object of [User] for which call is to be initiated
  final User? user;

  ///[group] is a object of [Group] for which call is to be initiated
  final Group? group;

  ///[voiceCallIconURL] is a string which sets the url for the voice call icon
  final String? voiceCallIconURL;

  ///[voiceCallIconPackage] is a string which sets the package name for the voice call icon
  final String? voiceCallIconPackage;

  ///[voiceCallIconText] is a string which sets the text for the voice call icon
  final String? voiceCallIconText;

  ///[voiceCallIconHoverText] is a string which sets the hover text for the voice call icon
  final String? voiceCallIconHoverText;

  ///[videoCallIconURL] is a string which sets the url for the video call icon
  final String? videoCallIconURL;

  ///[videoCallIconPackage] is a string which sets the package name for the video call icon
  final String? videoCallIconPackage;

  ///[videoCallIconText] is a string which sets the text for the video call icon
  final String? videoCallIconText;

  ///[videoCallIconHoverText] is a string which sets the hover text for the video call icon
  final String? videoCallIconHoverText;

  ///[onVoiceCallClick] is a callback which gets called when voice call icon is clicked
  final Function(BuildContext, User?, Group?)? onVoiceCallClick;

  ///[onVideoCallClick] is a callback which gets called when video call icon is clicked
  final Function(BuildContext, User?, Group?)? onVideoCallClick;

  ///[callButtonsStyle] is a object of [CallButtonsStyle] which sets the style for the call buttons
  final CallButtonsStyle? callButtonsStyle;

  ///[_callButtonsController] is an instance of [CometChatCallButtonsController] the view model of this widget
  final CometChatCallButtonsController _callButtonsController;

  ///[hideVoiceCall] is a bool which hides the voice call icon
  final bool? hideVoiceCall;

  ///[hideVideoCall] is a bool which hides the video call icon
  final bool? hideVideoCall;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: GetBuilder(
            init: _callButtonsController,
            global: false,
            dispose: (GetBuilderState<CometChatCallButtonsController> state) =>
                state.controller?.onClose(),
            builder: (CometChatCallButtonsController viewModel) {
              viewModel.context = context;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (hideVoiceCall != true && group == null)
                    CometChatButton(
                      text: voiceCallIconText,
                      hoverText: voiceCallIconHoverText,
                      iconUrl: voiceCallIconURL,
                      iconPackage:
                          voiceCallIconPackage ?? UIConstants.packageName,
                      onTap: (context) {
                        if (!viewModel.disabled) {
                          if (onVoiceCallClick != null) {
                            onVoiceCallClick!(context, user, group);
                          } else {
                            viewModel.initiateCall(CallTypeConstants.audioCall);
                          }
                        }
                      },
                      buttonStyle: kit.ButtonStyle(
                        background: callButtonsStyle?.background,
                        iconTint: callButtonsStyle?.voiceCallIconTint,
                        border: callButtonsStyle?.border,
                        borderRadius: callButtonsStyle?.borderRadius,
                        gradient: callButtonsStyle?.gradient,
                        height: 300??callButtonsStyle?.height,
                        width: callButtonsStyle?.width,
                      ),
                    ),
                  if (hideVideoCall != true)
                    const SizedBox(
                      width: 20,
                    ),
                  if (hideVideoCall != true)
                    CometChatButton(
                      text: videoCallIconText,
                      hoverText: videoCallIconHoverText,
                      iconUrl: videoCallIconURL,
                      iconPackage:
                          videoCallIconPackage ?? UIConstants.packageName,
                      onTap: (context) {
                        if (viewModel.disabled == false) {
                          if (onVideoCallClick != null) {
                            onVideoCallClick!(context, user, group);
                          } else {
                            viewModel.initiateCall(CallTypeConstants.videoCall);
                          }
                        }
                      },
                      buttonStyle: kit.ButtonStyle(
                        background: callButtonsStyle?.background,
                        iconTint: callButtonsStyle?.videoCallIconTint,
                        border: callButtonsStyle?.border,
                        borderRadius: callButtonsStyle?.borderRadius,
                        gradient: callButtonsStyle?.gradient,
                        height: callButtonsStyle?.height,
                        width: callButtonsStyle?.width,
                      ),
                    ),
                ],
              );
            }));
  }
}
