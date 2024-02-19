import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CallLogHistoryConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [CometChatCallLogHistory]
///```dart
/// CallLogHistoryConfiguration(
/// title: "Call Logs",
/// emptyStateText: "No call logs found",
/// )
/// ```
class CallLogHistoryConfiguration {
  CallLogHistoryConfiguration({
    this.title,
    this.listItemView,
    this.backButton,
    this.showBackButton,
    this.emptyStateText,
    this.emptyStateView,
    this.errorStateText,
    this.errorStateView,
    this.loadingIconUrl,
    this.loadingStateView,
    this.onError,
    this.onBack,
    this.theme,
    this.tailView,
    this.callLogsBuilderProtocol,
    this.timePattern,
    this.dateSeparatorPattern,
    this.hideSeparator = true,
    this.callLogsRequestBuilder,
    this.callLogHistoryStyle,
    this.onItemClick,
    this.callLogDetailsConfiguration,
  });

  ///[title] Title of the callLog list component
  final String? title;

  ///[listItemView] set custom view for each callLog
  final Widget? Function(CallLog callLog, BuildContext context)? listItemView;

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

  ///[onError] callback triggered in case any error happens when fetching callLogs
  final OnError? onError;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  ///[tailView] a custom widget for the tail section of the callLog list item
  final Function(CallLog callLog, BuildContext context)? tailView;

  ///[callLogsBuilderProtocol] set custom call  Logs request builder protocol
  final CallLogsBuilderProtocol? callLogsBuilderProtocol;

  ///[callLogsRequestBuilder] set custom call Logs request builder
  final CallLogRequestBuilder? callLogsRequestBuilder;

  ///[timePattern] custom time pattern visible in call Logs
  final String? timePattern;

  ///[dateSeparatorPattern] pattern for  date separator
  final String? dateSeparatorPattern;

  ///[hideSeparator] toggle visibility of separator
  final bool? hideSeparator;

  ///[onItemClick] callback triggered on clicking of the callLog item
  final Function(CallLog callLog)? onItemClick;

  ///[callLogHistoryStyle] style for every call logs
  final CallLogHistoryStyle? callLogHistoryStyle;

  ///[callLogDetailsConfiguration] used to set the configuration properties of [CometChatCallLogDetails]
  final CallLogDetailsConfiguration? callLogDetailsConfiguration;

}
