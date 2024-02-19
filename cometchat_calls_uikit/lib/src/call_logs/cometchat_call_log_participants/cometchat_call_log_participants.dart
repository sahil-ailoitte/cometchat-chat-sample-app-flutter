import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as cc;
import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CometChatCallLogParticipants] is a component that displays a list of call participants with the help of [CometChatListBase] and [CometChatListItem]
///
///
/// ```dart
///   CometChatCallLogParticipants(
///   participantsStyle: CallLogParticipantsStyle(),
/// );
/// `
class CometChatCallLogParticipants extends StatefulWidget {
  const CometChatCallLogParticipants({
    Key? key,
    required this.callLog,
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
  }) : super(key: key);

  ///[callLog] callLog object for CallLog participant
  final CallLog callLog;

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

  @override
  State<CometChatCallLogParticipants> createState() =>
      _CometChatCallLogParticipantsState();
}

class _CometChatCallLogParticipantsState
    extends State<CometChatCallLogParticipants> {
  late CometChatTheme _theme;

  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? cometChatTheme;
    _initializeLoggedInUser();
  }

  _initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (loggedInUser == null)
        ? const Scaffold()
        : CometChatListBase(
            title: widget.title ?? cc.Translations.of(context).participants,
            hideSearch: true,
            backIcon: widget.backButton ??
                Image.asset(
                  AssetConstants.back,
                  package: UIConstants.packageName,
                  color: _theme.palette.getAccent(),
                ),
            showBackButton: widget.showBackButton ?? true,
            onBack: widget.onBack ??
                () {
                  Navigator.of(context).pop();
                },
            style: ListBaseStyle(
              background: (widget.participantsStyle?.gradient == null)
                  ? widget.participantsStyle?.background
                  : Colors.transparent,
              titleStyle: widget.participantsStyle?.titleStyle ??
                  TextStyle(
                    fontSize: _theme.typography.heading.fontSize,
                    fontWeight: _theme.typography.heading.fontWeight,
                    color: _theme.palette.getAccent(),
                  ),
              gradient: widget.participantsStyle?.gradient,
              height: widget.participantsStyle?.height,
              width: widget.participantsStyle?.width,
              backIconTint: widget.participantsStyle?.backIconTint ??
                  _theme.palette.getPrimary(),
              border: widget.participantsStyle?.border,
              borderRadius: widget.participantsStyle?.borderRadius,
            ),
            container: (widget.callLog.participants == null ||
                    widget.callLog.participants!.isEmpty)
                ? _emptyView(context, _theme)
                : ListView.builder(
                    itemCount: widget.callLog.participants!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final participant = widget.callLog.participants![index];
                      return _getListItemView(participant, context, _theme);
                    },
                  ),
          );
  }

  // Empty Widget
  Widget _emptyView(BuildContext context, CometChatTheme theme) {
    if (widget.emptyStateView != null) {
      return widget.emptyStateView!(context);
    } else {
      return Center(
        child: Text(
          widget.emptyStateText ??
              cc.Translations.of(context).no_participants_found,
          style: widget.participantsStyle?.emptyTextStyle ??
              TextStyle(
                fontSize: theme.typography.title1.fontSize,
                fontWeight: theme.typography.title1.fontWeight,
                color: theme.palette.getAccent400(),
              ),
        ),
      );
    }
  }

  // list item view
  _getListItemView(
      Participants participant, BuildContext context, CometChatTheme theme) {
    if (widget.listItemView != null) {
      return widget.listItemView!(participant, context);
    } else {
      return CometChatListItem(
        hideSeparator: widget.hideSeparator,
        avatarURL: participant.avatar,
        avatarName: participant.name,
        title: participant.name,
        style: widget.listItemStyle ??
            ListItemStyle(
                titleStyle: widget.participantsStyle?.nameTextStyle ??
                    TextStyle(
                      fontSize: _theme.typography.name.fontSize,
                      fontWeight: _theme.typography.heading.fontWeight,
                      color: _theme.palette.getAccent700(),
                    ),
                background: widget.participantsStyle?.gradient == null
                    ? widget.participantsStyle?.background
                    : Colors.transparent,
                gradient: widget.participantsStyle?.gradient,
                height: widget.participantsStyle?.height,
                width: widget.participantsStyle?.width,
                border: widget.participantsStyle?.border,
                borderRadius: widget.participantsStyle?.borderRadius),
        subtitleView: _getSubTitleView(
          participant,
          context,
          _theme,
        ),
        tailView: _getTailView(
          participant,
          context,
          _theme,
        ),
        avatarStyle: widget.avatarStyle ??
            AvatarStyle(
              height: widget.avatarStyle?.height,
              width: widget.avatarStyle?.width,
              background: widget.avatarStyle?.background,
              border: widget.avatarStyle?.border,
              borderRadius: widget.avatarStyle?.borderRadius,
              gradient: widget.avatarStyle?.gradient,
              nameTextStyle: widget.avatarStyle?.nameTextStyle,
              outerBorderRadius: widget.avatarStyle?.outerBorderRadius,
              outerViewBackgroundColor:
                  widget.avatarStyle?.outerViewBackgroundColor,
              outerViewBorder: widget.avatarStyle?.outerViewBorder,
              outerViewSpacing: widget.avatarStyle?.outerViewSpacing,
              outerViewWidth: widget.avatarStyle?.outerViewWidth,
            ),
      );
    }
  }

  // sub title view
  _getSubTitleView(
      Participants participant, BuildContext context, CometChatTheme theme) {
    if (widget.subTitleView != null) {
      return widget.subTitleView!(context, participant);
    } else {
      return Text(
        CallLogsUtils.formatMinutesAndSeconds(
            participant.totalDurationInMinutes ?? 0.0),
        style: widget.participantsStyle?.subTitleStyle ??
            TextStyle(
              fontSize: theme.typography.subtitle1.fontSize,
              fontWeight: theme.typography.name.fontWeight,
              color: theme.palette.getAccent400(),
            ),
      );
    }
  }

  // tail view
  _getTailView(
      Participants participant, BuildContext context, CometChatTheme theme) {
    if (widget.tailView != null) {
      return widget.tailView!(context, participant);
    } else {
      return CallLogsUtils.getTime(
          theme,
          widget.participantsStyle?.tailTitleStyle,
          context,
          participant.joinedAt,
          datePattern: widget.datePattern);
    }
  }
}
