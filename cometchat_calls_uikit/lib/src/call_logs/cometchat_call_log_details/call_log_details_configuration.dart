import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CallLogDetailsConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [CometChatCallLogDetails]
///```dart
/// CallLogDetailsConfiguration(
/// title: "Details",
/// theme: CometChatTheme(),
/// )
/// ```
class CallLogDetailsConfiguration {
  CallLogDetailsConfiguration({
    this.theme,
    this.title,
    this.detailStyle,
    this.showBackButton = true,
    this.backButton,
    this.avatarStyle,
    this.customProfileView,
    this.onBack,
    this.participantsConfiguration,
    this.recordingsConfiguration,
    this.callLogHistoryConfiguration,
    this.onError,
    this.data,
    this.stateCallBack,
    this.callButtonsConfiguration,
    this.hideRecordingsCount = false,
    this.hideParticipantsCount = false,
    this.hideCallButtons = false,
    this.hideProfile = false,
    this.separatorDatePattern,
    this.arrowIcon,
    this.datePattern,
    this.outgoingCallConfiguration,
  });

  /// [theme] custom theme
  final CometChatTheme? theme;

  ///to pass [CometChatDetails] header text use [title]
  final String? title;

  ///[detailsStyle] is used to pass styling properties
  final CallLogDetailsStyle? detailStyle;

  ///[showBackButton] toggles visibility for back button
  final bool? showBackButton;

  ///[backButton] returns back button
  final Widget? backButton;

  ///[avatarStyle] set style for avatar
  final AvatarStyle? avatarStyle;

  ///[customProfileView] provides a customized view profile
  final Widget? customProfileView;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///configurations for opening [CometChatCallLogParticipants]
  final CallLogParticipantsConfiguration? participantsConfiguration;

  ///configurations for opening [CometChatCallLogRecordings]
  final CallLogRecordingsConfiguration? recordingsConfiguration;

  ///configurations for viewing [CometChatCallLogHistory]
  final CallLogHistoryConfiguration? callLogHistoryConfiguration;

  ///configurations for [CometChatCallButtons]
  final CallButtonsConfiguration? callButtonsConfiguration;

  ///[onError] callback triggered in case any error happens
  final OnError? onError;

  ///[stateCallBack] a call back to give state to its parent
  final void Function(CometChatCallLogDetailsController)? stateCallBack;

  ///list of templates is passed to [data] which is used in displaying options
  final List<CometChatCallLogDetailsTemplate>? Function(CallLog? callLog)? data;

  ///[hideProfile] hides view profile for users
  final bool? hideProfile;

  ///[hideParticipantsCount] hides view profile for users
  final bool? hideParticipantsCount;

  ///[hideRecordingsCount] hides view profile for users
  final bool? hideRecordingsCount;

  ///[hideRecordingsCount] hides view profile for users
  final bool? hideCallButtons;

  ///[separatorDatePattern] custom date pattern
  final String? separatorDatePattern;

  ///[datePattern] custom date pattern
  final String? datePattern;

  ///[arrowIcon] to set custom icon
  final String? arrowIcon;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final OutgoingCallConfiguration? outgoingCallConfiguration;
}
