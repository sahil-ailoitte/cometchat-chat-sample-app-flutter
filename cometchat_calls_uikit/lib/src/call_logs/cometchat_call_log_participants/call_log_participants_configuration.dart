import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CallLogParticipantsConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [CometChatCallLogParticipants]
///```dart
/// CallLogParticipantsConfiguration(
/// title: "Participants",
/// emptyStateText: "No participants found",
/// )
/// ```
class CallLogParticipantsConfiguration {
  CallLogParticipantsConfiguration({
    this.title,
    this.listItemView,
    this.subTitleView,
    this.backButton,
    this.showBackButton,
    this.emptyStateText,
    this.emptyStateView,
    this.onError,
    this.onBack,
    this.avatarStyle,
    this.theme,
    this.tailView,
    this.datePattern,
    this.hideSeparator = true,
    this.listItemStyle,
    this.participantsStyle,
  });

  ///[title] Title of the participants list component
  final String? title;

  ///[listItemView] set custom list view for each participant
  final Widget? Function(Participants participants, BuildContext context)?
      listItemView;

  ///[subTitleView] set custom sub title view for each participant
  final Widget? Function(
    BuildContext context,
    Participants participants,
  )? subTitleView;

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

  ///[avatarStyle] set style for avatar
  final AvatarStyle? avatarStyle;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  ///[tailView] a custom widget for the tail section of the callLog participants list
  final Function(BuildContext context, Participants participants)? tailView;

  ///[datePattern] custom date pattern visible in participants
  final String? datePattern;

  ///[hideSeparator] toggle visibility of separator
  final bool? hideSeparator;

  ///[listItemStyle] style for every list item
  final ListItemStyle? listItemStyle;

  ///[participantsStyle] style for every participant
  final CallLogParticipantsStyle? participantsStyle;
}
