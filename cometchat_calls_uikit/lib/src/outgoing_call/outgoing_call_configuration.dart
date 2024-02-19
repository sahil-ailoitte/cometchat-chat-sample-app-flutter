import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart'
as kit;

///[OutgoingCallConfiguration] is a data class that has configuration properties for  [CometChatOutgoingCallScreen]
///
/// ```dart
/// OutgoingCallConfiguration(
/// theme: cometChatTheme,
/// subtitle: 'Calling',
/// declineButtonText: 'Decline',
/// declineButtonIconUrl: 'https://example.com/decline.png',
/// declineButtonIconUrlPackage: 'assets',
/// cardStyle: CardStyle( ),
/// buttonStyle: kit.ButtonStyle(
/// backgroundColor: Colors.red,
/// ),
/// onDecline: (context, call) {
/// print('Call Declined');
/// },
/// disableSoundForCalls: true,
/// customSoundForCalls: 'custom_sound_for_calls',
/// customSoundForCallsPackage: 'assets',
/// );
/// ```
///
class OutgoingCallConfiguration {

  OutgoingCallConfiguration(
      {this.theme,
        this.subtitle,
        this.declineButtonText,
        this.declineButtonIconUrl,
        this.declineButtonIconUrlPackage,
        this.cardStyle,
        this.buttonStyle,
        this.onDecline,
        this.disableSoundForCalls,
        this.customSoundForCalls,
        this.customSoundForCallsPackage,
      this.onError,
        this.outgoingCallStyle,
        this.ongoingCallConfiguration,
        this.avatarStyle
      });

  ///[theme] is used to set a custom theme for the widget.
  final CometChatTheme? theme;

  ///[subtitle] is used to define the subtitle for the widget.
  final String? subtitle;

  ///[declineButtonText] is used to define the decline button text for the widget.
  final String? declineButtonText;

  ///[declineButtonIconUrl] is used to define the decline button icon url for the widget.
  final String? declineButtonIconUrl;

  ///[declineButtonIconUrlPackage] is used to define the decline button icon url package for the widget.
  final String? declineButtonIconUrlPackage;

  ///[cardStyle] is used to define the card style for the widget.
  final CardStyle? cardStyle;

  ///[buttonStyle] is used to define the button style for the widget.
  final kit.ButtonStyle? buttonStyle;

  ///[onDecline] is used to define the callback for the widget when decline call button is tapped.
  final Function(BuildContext, Call)? onDecline;

  ///[disableSoundForCalls] is used to define whether to disable sound for call or not.
  final bool? disableSoundForCalls;

  ///[customSoundForCalls] is used to define the custom sound for calls.
  final String? customSoundForCalls;

  ///[customSoundForCallsPackage] is used to define the custom sound for calls.
  final String? customSoundForCallsPackage;

  ///[onError] is called when some error occurs
  final OnError? onError;

  ///[outgoingCallStyle] is used to set a custom incoming call style
  final OutgoingCallStyle? outgoingCallStyle;

  ///[ongoingCallConfiguration] is used to define the configuration for ongoing call screen.
  final OngoingCallConfiguration? ongoingCallConfiguration;

  ///[avatarStyle] is a object of [AvatarStyle] which sets the style for the avatar
  final AvatarStyle? avatarStyle;
}