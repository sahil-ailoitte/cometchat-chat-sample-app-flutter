import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CallLogsConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [CometChatCallLogs]
///```dart
/// CallLogsConfiguration(
/// title: "Call Logs",
/// emptyStateText: "No call logs found",
/// )
/// ```
class CallLogsConfiguration {
  CallLogsConfiguration({
    this.title,
    this.listItemView,
    this.subTitleView,
    this.backButton,
    this.showBackButton,
    this.emptyStateText,
    this.emptyStateView,
    this.errorStateText,
    this.errorStateView,
    this.loadingIconUrl,
    this.loadingStateView,
    this.onItemClick,
    this.onError,
    this.onBack,
    this.avatarStyle,
    this.theme,
    this.tailView,
    this.callLogsBuilderProtocol,
    this.datePattern,
    this.dateSeparatorPattern,
    this.hideSeparator = true,
    this.onInfoIconClick,
    this.infoIconUrl,
    this.listItemStyle,
    this.callLogsStyle,
    this.outgoingCallConfiguration,
    this.callLogsRequestBuilder,
    this.incomingAudioCallIcon,
    this.incomingVideoCallIcon,
    this.missedAudioCallIcon,
    this.missedVideoCallIcon,
    this.outgoingAudioCallIcon,
    this.outgoingVideoCallIcon,
  });

  ///[title] Title of the callLog list component
  final String? title;

  ///[listItemView] set custom view for each callLog
  final Widget? Function(CallLog callLog, BuildContext context)? listItemView;

  ///[listItemView] set custom sub title view for each callLog
  final Widget? Function(CallLog callLog, BuildContext context)? subTitleView;

  ///[backButton] returns back button
  final Widget? backButton;

  ///[showBackButton] switch on/off back button
  final bool? showBackButton;

  ///[emptyStateText] text to be displayed when the state is empty
  final String? emptyStateText;

  ///[emptyStateView]  returns view fow empty state
  final WidgetBuilder? emptyStateView;

  ///[errorStateText] text to be displayed when error occur
  final String? errorStateText;

  ///[errorStateView] returns view fow error state
  final WidgetBuilder? errorStateView;

  ///[loadingIconUrl] url to be displayed when loading
  final String? loadingIconUrl;

  ///[loadingStateView] returns view fow loading state
  final WidgetBuilder? loadingStateView;

  ///[onItemClick] custom callback for item being clicked
  final Function(CallLog callLog)? onItemClick;

  ///[onError] callback triggered in case any error happens when fetching callLogs
  final OnError? onError;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///[avatarStyle] customize avatar style
  final AvatarStyle? avatarStyle;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  ///[tailView] a custom widget for the tail section of the callLog list item
  final Function(BuildContext context, CallLog callLog)? tailView;


  ///[callLogsBuilderProtocol] set custom callLogs request builder protocol
  final CallLogsBuilderProtocol? callLogsBuilderProtocol;

  ///[callLogsRequestBuilder] set custom callLogs request builder
  final CallLogRequestBuilder? callLogsRequestBuilder;

  ///[datePattern] custom date pattern visible in callLogs
  final String? datePattern;

  ///[dateSeparatorPattern] pattern for  date separator
  final String? dateSeparatorPattern;

  ///[hideSeparator] toggle visibility of separator
  final bool? hideSeparator;

  ///[onInfoIconClick] callback triggered on clicking of the info icon
  final Function(CallLog? callLog)? onInfoIconClick;

  ///[infoIconUrl] customize the info icon
  final String? infoIconUrl;

  ///[listItemStyle] style for every list item
  final ListItemStyle? listItemStyle;

  ///[callLogsStyle] style for every call logs
  final CallLogsStyle? callLogsStyle;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final OutgoingCallConfiguration? outgoingCallConfiguration;

  ///[incomingAudioCallIcon] custom incoming audio icon
  final String? incomingAudioCallIcon;

  ///[incomingVideoCallIcon] custom incoming video icon
  final String? incomingVideoCallIcon;

  ///[outgoingAudioCallIcon] custom outgoing audio icon
  final String? outgoingAudioCallIcon;

  ///[outgoingVideoCallIcon] custom outgoing video icon
  final String? outgoingVideoCallIcon;

  ///[missedAudioCallIcon] custom missed audio icon
  final String? missedAudioCallIcon;

  ///[missedVideoCallIcon] custom missed video icon
  final String? missedVideoCallIcon;
}
