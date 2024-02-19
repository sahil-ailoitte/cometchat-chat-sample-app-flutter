import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as cc;

///[CometChatCallLogRecordings] is a component that displays a list of call recordings with the help of [CometChatListBase]
///
///
/// ```dart
///   CometChatCallLogRecordings(
///   recordingsStyle: CallLogRecordingsStyle(),
/// );
/// `
class CometChatCallLogRecordings extends StatefulWidget {
  const CometChatCallLogRecordings({
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
    this.theme,
    this.tailView,
    this.datePattern,
    this.hideSeparator = true,
    this.recordingsStyle,
    this.onDownloadClick,
    this.downloadIconUrl,
  }) : super(key: key);

  ///[callLog] callLog object for CallLog recordings
  final CallLog callLog;

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

  @override
  State<CometChatCallLogRecordings> createState() =>
      _CometChatCallLogRecordingsState();
}

class _CometChatCallLogRecordingsState
    extends State<CometChatCallLogRecordings> {
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
            title: widget.title ?? cc.Translations.of(context).recording,
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
              background: (widget.recordingsStyle?.gradient == null)
                  ? widget.recordingsStyle?.background
                  : Colors.transparent,
              titleStyle: widget.recordingsStyle?.titleStyle ??
                  TextStyle(
                    fontSize: _theme.typography.heading.fontSize,
                    fontWeight: _theme.typography.heading.fontWeight,
                    color: _theme.palette.getAccent(),
                  ),
              gradient: widget.recordingsStyle?.gradient,
              height: widget.recordingsStyle?.height,
              width: widget.recordingsStyle?.width,
              backIconTint: widget.recordingsStyle?.backIconTint ??
                  _theme.palette.getPrimary(),
              border: widget.recordingsStyle?.border,
              borderRadius: widget.recordingsStyle?.borderRadius,
            ),
            container: (widget.callLog.recordings == null ||
                    widget.callLog.recordings!.isEmpty)
                ? _emptyView(context, _theme)
                : ListView.separated(
                    itemCount: widget.callLog.recordings?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final recording = widget.callLog.recordings?[index];
                      if (recording == null) return const SizedBox();
                      return (widget.listItemView != null)
                          ? widget.listItemView!(recording, context)
                          : ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                recording.rid ?? "",
                              ),
                              titleTextStyle: widget
                                      .recordingsStyle?.recordingTitleStyle ??
                                  TextStyle(
                                    fontSize: _theme.typography.title2.fontSize,
                                    fontWeight:
                                        _theme.typography.heading.fontWeight,
                                    color: _theme.palette.getAccent700(),
                                  ),
                              subtitle:
                                  _getSubTitleView(recording, context, _theme),
                              trailing:
                                  _getTailView(recording, context, _theme),
                            );
                    },
                    separatorBuilder: (context, index) {
                      return (widget.hideSeparator != null &&
                              widget.hideSeparator!)
                          ? const SizedBox()
                          : Divider(
                              color: widget.recordingsStyle?.dividerTint ??
                                  _theme.palette.getAccent500(),
                            );
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
              cc.Translations.of(context).no_recordings_found,
          style: widget.recordingsStyle?.emptyTextStyle ??
              TextStyle(
                fontSize: theme.typography.title1.fontSize,
                fontWeight: theme.typography.title1.fontWeight,
                color: theme.palette.getAccent400(),
              ),
        ),
      );
    }
  }

  _getSubTitleView(
      Recordings recording, BuildContext context, CometChatTheme theme) {
    return widget.subTitleView?.call(recording, context) ??
        Text(
          CallLogsUtils.formatMinutesAndSeconds(recording.duration ?? 0.0),
          style: widget.recordingsStyle?.durationTextStyle ??
              TextStyle(
                fontSize: theme.typography.subtitle2.fontSize,
                fontWeight: theme.typography.heading.fontWeight,
                color: theme.palette.getAccent400(),
              ),
        );
  }

  _getTailView(
      Recordings recording, BuildContext context, CometChatTheme theme) {
    return widget.tailView?.call(context, recording) ??
        SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CallLogsUtils.getTime(
                    theme,
                    widget.recordingsStyle?.tailTitleStyle,
                    context,
                    recording.startTime,
                    datePattern: widget.datePattern),
              ),
              IconButton(
                onPressed: () async {
                  if (widget.onDownloadClick != null) {
                    widget.onDownloadClick!(recording);
                  } else {
                    await UIConstants.channel.invokeMethod(
                      "download",
                      {
                        "fileUrl": recording.recordingUrl,
                      },
                    );
                  }
                },
                icon: Image.asset(
                  widget.downloadIconUrl ?? AssetConstants.download,
                  package: UIConstants.packageName,
                  color: widget.recordingsStyle?.downLoadIconTint ??
                      _theme.palette.getAccent700(),
                ),
              ),
            ],
          ),
        );
  }
}
