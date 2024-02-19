import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
// import 'package:cometchat_calls_uikit/src/shared/views/button/button_style.dart'
// as kit;


///[CallButtonsConfiguration] is a data class that has configuration properties
///
/// ```dart
/// CallButtonsConfiguration(
/// voiceCallIconURL: '',
/// voiceCallIconPackage: '',
/// voiceCallIconText: '',
/// voiceCallIconHoverText: '',
/// videoCallIconURL: '',
/// videoCallIconPackage: '',
/// videoCallIconText: '',
/// videoCallIconHoverText: '',
/// onVoiceCallClick: (context) {
/// print('Voice Call');
/// },
/// onVideoCallClick: (context) {
/// print('Video Call');
/// },
/// callButtonsStyle: CallButtonsStyle(
/// borderRadius: 8,
/// color: Colors.blue,
/// ),
/// theme: cometChatTheme,
/// alignment: BubbleAlignment.left,
/// );
///
class CallButtonsConfiguration {

  CallButtonsConfiguration({
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
    this.onError,
    this.ongoingCallConfiguration,
    this.outgoingCallConfiguration,
    this.hideVideoCall,
    this.hideVoiceCall
  });

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

  ///[onError] is a callback which gets called when there is an error in call
  final OnError? onError;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final OutgoingCallConfiguration? outgoingCallConfiguration;

  ///[ongoingCallConfiguration] is used to define the configuration for ongoing call screen.
  final OngoingCallConfiguration? ongoingCallConfiguration;

  ///[hideVoiceCall] is a bool which hides the voice call icon
  final bool? hideVoiceCall;

  ///[hideVideoCall] is a bool which hides the video call icon
  final bool? hideVideoCall;
}