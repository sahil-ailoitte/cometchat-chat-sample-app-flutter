import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as cc;
import 'package:get/get.dart';

///[CometChatCallLogs] is a component that displays a list of callLogs with the help of [CometChatListBase] and [CometChatListItem]
///fetched callLogs are listed down in order of recent activity
///callLogs are fetched using [CallLogsBuilderProtocol] and [CallLogRequestBuilder]
///
///
/// ```dart
///   CometChatCallLogs(
///   callLogsStyle: CallLogsStyle(),
/// );
/// `
class CometChatCallLogs extends StatefulWidget {
  CometChatCallLogs({
    Key? key,
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
  }) : super(key: key);

  ///[title] Title of the callLog list component
  final String? title;

  ///[listItemView] set custom view for each callLog
  final Widget? Function(CallLog callLog, BuildContext context)? listItemView;

  ///[subTitleView] set custom sub title view for each callLog
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

  ///[onItemClick] callback triggered on clicking of the callLog item
  final Function(CallLog callLog)? onItemClick;

  ///[onError] callback triggered in case any error happens when fetching callLogs
  final OnError? onError;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///[avatarStyle] customize avatar
  final AvatarStyle? avatarStyle;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  ///[tailView] a custom widget for the tail section of the callLog list item
  final Function(BuildContext context, CallLog callLog)? tailView;

  ///[callLogsBuilderProtocol] set custom call Log request builder protocol
  final CallLogsBuilderProtocol? callLogsBuilderProtocol;

  ///[callLogRequestBuilder] set custom conversations request builder
  final CallLogRequestBuilder? callLogsRequestBuilder;

  ///[datePattern] custom date pattern visible in callLogs
  final String? datePattern;

  ///[dateSeparatorPattern] pattern for  date separator
  final String? dateSeparatorPattern;

  ///[hideSeparator] toggle visibility of separator
  final bool? hideSeparator;

  ///[onInfoIconClick] callback triggered on clicking of the info icon
  final Function(CallLog callLog)? onInfoIconClick;

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

  @override
  State<CometChatCallLogs> createState() => _CometChatCallLogsState();
}

class _CometChatCallLogsState extends State<CometChatCallLogs> {
  late CometChatTheme _theme;

  CometChatCallLogsController? _callLogsController;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? cometChatTheme;
    initialize();
  }

  void initialize() async {
    String? userAuthToken = await CometChatUIKitCalls.getUserAuthToken();
    _callLogsController = CometChatCallLogsController(
      callLogsBuilderProtocol: widget.callLogsBuilderProtocol ??
          UICallLogsBuilder(
              widget.callLogsRequestBuilder ?? CallLogRequestBuilder()
                ..authToken = userAuthToken
                ..callCategory = CometChatCallsConstants.callCategoryCall),
      onError: widget.onError,
      outgoingCallConfiguration: widget.outgoingCallConfiguration,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (_callLogsController == null)
        ? const Scaffold()
        : CometChatListBase(
            title: widget.title ?? cc.Translations.of(context).calls,
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
              background: (widget.callLogsStyle?.gradient == null)
                  ? widget.callLogsStyle?.background
                  : Colors.transparent,
              titleStyle: widget.callLogsStyle?.titleStyle ??
                  TextStyle(
                    fontSize: _theme.typography.heading.fontSize,
                    fontWeight: _theme.typography.heading.fontWeight,
                    color: _theme.palette.getAccent(),
                  ),
              gradient: widget.callLogsStyle?.gradient,
              height: widget.callLogsStyle?.height,
              width: widget.callLogsStyle?.width,
              backIconTint: widget.callLogsStyle?.backIconTint ??
                  _theme.palette.getPrimary(),
              border: widget.callLogsStyle?.border,
              borderRadius: widget.callLogsStyle?.borderRadius,
            ),
            container: GetBuilder(
              init: _callLogsController,
              builder: (CometChatCallLogsController value) {
                if (value.hasError == true) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _showError(value, context, _theme));
                  if (widget.errorStateView != null) {
                    return widget.errorStateView!(context);
                  }
                  return _getLoadingIndicator(context, _theme);
                } else if (value.isLoading == true && value.list.isEmpty) {
                  return _getLoadingIndicator(context, _theme);
                } else {
                  return (value.list.isEmpty)
                      ? _emptyView(context, _theme)
                      : ListView.builder(
                          itemCount: value.hasMoreItems
                              ? value.groupedEntries.length + 1
                              : value.groupedEntries.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == value.groupedEntries.length) {
                              value.loadMoreElements();
                              return _getLoadingIndicator(context, _theme);
                            }
                            if (value.groupedEntries.isEmpty) {
                              return _emptyView(context, _theme);
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CallLogsUtils.getDateTimeTitle(
                                    _theme,
                                    value.groupedEntries,
                                    index,
                                    widget.dateSeparatorPattern,
                                    widget.callLogsStyle?.titleStyle,
                                    context),
                                ListView.builder(
                                  itemCount: CallLogsUtils.returnCallLogList(
                                    value.groupedEntries,
                                    index,
                                  ).length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    final log = CallLogsUtils.returnCallLogList(
                                      value.groupedEntries,
                                      index,
                                    )[i];
                                    return (widget.listItemView != null)
                                        ? widget.listItemView!(log, context)!
                                        : GestureDetector(
                                            onTap: () {
                                              if (widget.onItemClick != null) {
                                                widget.onItemClick!(log);
                                              } else {
                                                if (CallLogsUtils.isUser(log)) {
                                                  value.initiateCall(
                                                    log,
                                                    context,
                                                  );
                                                }
                                              }
                                            },
                                            child: CometChatListItem(
                                              hideSeparator:
                                                  widget.hideSeparator,
                                              avatarURL:
                                                  CallLogsUtils.receiverAvatar(
                                                value.loggedInUser!,
                                                log,
                                              ),
                                              avatarName:
                                                  CallLogsUtils.receiverName(
                                                value.loggedInUser!,
                                                log,
                                              ),
                                              title: CallLogsUtils.receiverName(
                                                value.loggedInUser!,
                                                log,
                                              ),
                                              style: widget.listItemStyle ??
                                                  ListItemStyle(
                                                    titleStyle: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: _theme
                                                          .typography
                                                          .name
                                                          .fontSize,
                                                      fontWeight: _theme
                                                          .typography
                                                          .heading
                                                          .fontWeight,
                                                      color: CallUtils
                                                          .getCallStatusColor(
                                                        log,
                                                        value.loggedInUser,
                                                        _theme,
                                                      ),
                                                    ),
                                                  ),
                                              subtitleView: _getSubTitleView(
                                                value,
                                                log,
                                                context,
                                                _theme,
                                              ),
                                              tailView: _getTailView(
                                                context,
                                                value,
                                                log,
                                              ),
                                              avatarStyle: widget.avatarStyle ??
                                                  const AvatarStyle(),
                                            ),
                                          );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                }
              },
            ),
          );
  }

  // tail widget
  Widget _getTailView(
      BuildContext context, CometChatCallLogsController value, CallLog log) {
    if (widget.tailView != null) {
      return widget.tailView!(context, log);
    } else {
      return CallLogsUtils.getTime(_theme, widget.callLogsStyle?.tailTitleStyle,
          context, log.initiatedAt,
          datePattern: widget.datePattern);
    }
  }

  // Sub title widget
  _getSubTitleView(CometChatCallLogsController value, CallLog callLog,
      BuildContext context, CometChatTheme theme) {
    if (widget.subTitleView != null) {
      return widget.subTitleView!(callLog, context);
    } else {
      return Row(
        children: [
          Image.asset(
            CallUtils.getCallIcon(
              context,
              callLog,
              value.loggedInUser,
              incomingAudioCallIcon: widget.incomingAudioCallIcon,
              incomingVideoCallIcon: widget.incomingVideoCallIcon,
              missedAudioCallIcon: widget.missedAudioCallIcon,
              missedVideoCallIcon: widget.missedVideoCallIcon,
              outgoingAudioCallIcon: widget.outgoingAudioCallIcon,
              outgoingVideoCallIcon: widget.outgoingVideoCallIcon,
            ),
            package: UIConstants.packageName,
            color: widget.callLogsStyle?.callStatusIconTint ??
                theme.palette.getAccent600(),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              CallUtils.getStatus(context, callLog, value.loggedInUser),
              overflow: TextOverflow.ellipsis,
              style: widget.callLogsStyle?.subTitleStyle ??
                  TextStyle(
                    fontSize: theme.typography.subtitle1.fontSize,
                    fontWeight: theme.typography.name.fontWeight,
                    color: theme.palette.getAccent400(),
                  ),
            ),
          ),
        ],
      );
    }
  }

  // Loading Widget
  Widget _getLoadingIndicator(BuildContext context, CometChatTheme theme) {
    if (widget.loadingStateView != null) {
      return widget.loadingStateView!(context);
    } else {
      return Center(
        child: Image.asset(
          widget.loadingIconUrl ?? AssetConstants.spinner,
          package: UIConstants.packageName,
          color: widget.callLogsStyle?.loadingIconTint ??
              theme.palette.getAccent600(),
        ),
      );
    }
  }

  // Empty Widget
  Widget _emptyView(BuildContext context, CometChatTheme theme) {
    if (widget.emptyStateView != null) {
      return widget.emptyStateView!(context);
    } else {
      return Center(
        child: Text(
          widget.emptyStateText ?? cc.Translations.of(context).no_Calls_found,
          style: widget.callLogsStyle?.emptyTextStyle ??
              TextStyle(
                fontSize: theme.typography.title1.fontSize,
                fontWeight: theme.typography.title1.fontWeight,
                color: theme.palette.getAccent400(),
              ),
        ),
      );
    }
  }

  // Error Widget
  _showError(CometChatCallLogsController controller, BuildContext context,
      CometChatTheme theme) {
    String error;

    if (controller.error != null && controller.error is CometChatException) {
      if (kDebugMode) {
        debugPrint(
            "error detected - > ${(controller.error as CometChatException).details}");
      }
      error = widget.errorStateText ??
          Utils.getErrorTranslatedText(
              context, (controller.error as CometChatException).code);
    } else {
      error =
          widget.errorStateText ?? cc.Translations.of(context).no_Calls_found;
    }
    if (widget.errorStateView != null) {}
    _showErrorDialog(error, context, theme, controller);
  }

  _showErrorDialog(String errorText, BuildContext context, CometChatTheme theme,
      CometChatCallLogsController controller) {
    showCometChatConfirmDialog(
      context: context,
      messageText: Text(
        widget.errorStateText ?? errorText,
        style: widget.callLogsStyle?.errorTextStyle ??
            TextStyle(
              fontSize: theme.typography.title2.fontSize,
              fontWeight: theme.typography.title2.fontWeight,
              color: theme.palette.getAccent(),
              fontFamily: theme.typography.title2.fontFamily,
            ),
      ),
      cancelButtonText: cc.Translations.of(context).ok,
      style: ConfirmDialogStyle(
          backgroundColor: theme.palette.mode == PaletteThemeModes.light
              ? theme.palette.getBackground()
              : Color.alphaBlend(
                  theme.palette.getAccent200(), theme.palette.getBackground()),
          shadowColor: theme.palette.getAccent300(),
          confirmButtonTextStyle: TextStyle(
              fontSize: theme.typography.text2.fontSize,
              fontWeight: theme.typography.text2.fontWeight,
              color: theme.palette.getPrimary()),
          cancelButtonTextStyle: TextStyle(
              fontSize: theme.typography.text2.fontSize,
              fontWeight: theme.typography.text2.fontWeight,
              color: theme.palette.getPrimary())),
      onCancel: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
