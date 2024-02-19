import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CallLogRecordingsConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [CometChatCallLogRecordings]
///```dart
/// CallLogRecordingsConfiguration(
/// title: "Recordings",
/// emptyStateText: "No recordings found",
/// )
/// ```
class CallLogRecordingsConfiguration {
  CallLogRecordingsConfiguration({
    this.title,
    this.listItemView,
    this.subTitleView,
    this.backButton,
    this.showBackButton,
    this.emptyStateText,
    this.emptyStateView,
    this.onError,
    this.onBack,
    this.theme,
    this.tailView,
    this.datePattern,
    this.hideSeparator = true,
    this.recordingsStyle,
    this.onDownloadClick,
    this.downloadIconUrl,
  });

  ///[title] Title of the participants list component
  final String? title;

  ///[listItemView] set custom list view for each recording
  final Widget? Function(Recordings recordings, BuildContext context)?
      listItemView;

  ///[subTitleView] set custom sub title view for each recording
  final Widget? Function(Recordings recordings, BuildContext context)?
      subTitleView;

  ///[backButton] set custom view for each callLog
  final Widget? backButton;

  ///[showBackButton] returns back button
  final bool? showBackButton;

  ///[emptyStateText] text to be displayed when the state is empty
  final String? emptyStateText;

  ///[emptyStateView] returns view fow empty state
  final WidgetBuilder? emptyStateView;

  ///[onError] callback triggered in case any error occurs
  final OnError? onError;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  ///[tailView] a custom widget for the tail section of the callLog recordings list
  final Function(BuildContext context, Recordings recordings)? tailView;

  ///[datePattern] custom date pattern visible in recordings
  final String? datePattern;

  ///[hideSeparator] toggle visibility of separator
  final bool? hideSeparator;

  ///[recordingsStyle] style for every recording
  final CallLogRecordingsStyle? recordingsStyle;

  ///[downloadIconUrl] set custom download icon
  final String? downloadIconUrl;

  ///[onDownloadClick] callBack triggered on clicking on download icon
  final Function(Recordings recording)? onDownloadClick;
}
