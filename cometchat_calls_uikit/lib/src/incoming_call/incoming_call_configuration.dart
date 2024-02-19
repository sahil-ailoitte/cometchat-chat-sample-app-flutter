import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as kit;

///[IncomingCallConfiguration] is a data class that has configuration properties
///
/// ```dart
/// IncomingCallConfiguration(
/// theme: cometChatTheme,
/// onError: (e) {
/// print(e.message);
/// },
/// disableSoundForCalls: true,
/// subtitle: 'Incoming Call',
/// customSoundForCalls: 'custom_sound_for_calls',
/// customSoundForCallsPackage: 'assets',
/// onDecline: (context, call) {
/// print('Call Declined');
/// },
/// declineButtonText: 'Decline',
/// declineButtonStyle: kit.ButtonStyle(
/// backgroundColor: Colors.red,
/// ),
/// declineButtonIconUrl: 'https://example.com/decline.png',
/// declineButtonIconUrlPackage: 'assets',
/// cardStyle: CardStyle( ),
/// );
class IncomingCallConfiguration {
  IncomingCallConfiguration(
      {
        this.theme,
        this.onError,
        this.disableSoundForCalls,
        this.subtitle,
        this.customSoundForCalls,
        this.customSoundForCallsPackage,
        this.onDecline,
        this.declineButtonText,
        this.declineButtonStyle,
        this.declineButtonIconUrl,
        this.declineButtonIconUrlPackage,
        this.cardStyle,
        this.onAccept,
        this.acceptButtonIconUrl,
        this.acceptButtonIconUrlPackage,
        this.acceptButtonStyle,
        this.acceptButtonText,
        this.incomingCallStyle,
        this.ongoingCallConfiguration,
        this.avatarStyle
      });

  ///[theme] is used to set a custom theme for the widget
  final CometChatTheme? theme;

  ///[onError] is called when some error occurs
  final OnError? onError;

  ///[subtitle] is used to set a custom subtitle for the widget
  final String? subtitle;

  ///[disableSoundForCalls] is used to disable sound for call
  final bool? disableSoundForCalls;

  ///[customSoundForCalls] is used to set a custom sound for calls
  final String? customSoundForCalls;

  ///[customSoundForCallsPackage] is used to define the custom sound for calls.
  final String? customSoundForCallsPackage;

  ///[declineButtonText] is used to set a custom decline button text
  final String? declineButtonText;

  ///[declineButtonIconUrl] is used to set a custom decline button icon url
  final String? declineButtonIconUrl;

  ///[declineButtonIconUrlPackage] is used to set a custom decline button icon url package
  final String? declineButtonIconUrlPackage;

  ///[cardStyle] is used to set a custom card style
  final CardStyle? cardStyle;

  ///[declineButtonStyle] is used to set a custom decline button style
  final kit.ButtonStyle? declineButtonStyle;

  ///[acceptButtonText] is used to set a custom accept button text
  final String? acceptButtonText;

  ///[acceptButtonIconUrl] is used to set a custom accept button icon url
  final String? acceptButtonIconUrl;

  ///[acceptButtonIconUrlPackage] is used to set a custom accept button icon url package
  final String? acceptButtonIconUrlPackage;

  ///[acceptButtonStyle] is used to set a custom accept button style
  final kit.ButtonStyle? acceptButtonStyle;

  ///[onDecline] is called when the call is declined
  final Function(BuildContext,Call)? onDecline;

  ///[onAccept] is called when the call is accepted
  final Function(BuildContext,Call)? onAccept;

  ///[incomingCallStyle] is used to set a custom incoming call style
  final IncomingCallStyle? incomingCallStyle;

  ///[ongoingCallConfiguration] is used to define the configuration for ongoing call screen.
  final OngoingCallConfiguration? ongoingCallConfiguration;

  ///[avatarStyle] is a object of [AvatarStyle] which sets the style for the avatar
  final AvatarStyle? avatarStyle;
}