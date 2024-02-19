import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as cc;
import 'package:get/get.dart';

///[CometChatCallLogHistory] is a component that displays a list of callLogs with the help of [CometChatListBase] and [CometChatListItem]
///fetched callLogs are listed down in order of recent activity
///callLogs are fetched using [CallLogsBuilderProtocol] and [CallLogRequestBuilder]
///
///
/// ```dart
///   CometChatCallLogHistory(
///   callLogHistoryStyle: CallLogHistoryStyle(),
/// );
/// `
class CometChatCallLogHistory extends StatefulWidget {
  const CometChatCallLogHistory({
    Key? key,
    this.callUser,
    this.callGroup,
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
    this.callLogDetailConfiguration,
  })  : assert(callUser != null || callGroup != null,
            "One of callUer or callGroup should be passed"),
        assert(callUser == null || callGroup == null,
            "Only one of CallUser or CallGroup should be passed"),
        super(key: key);

  ///[callUser] CallUser object for CallLog History
  final CallUser? callUser;

  ///[callGroup] CallGroup object for CallLog History
  final CallGroup? callGroup;

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

  ///[callLogsBuilderProtocol] set custom callLogs request builder protocol
  final CallLogsBuilderProtocol? callLogsBuilderProtocol;

  ///[callLogsRequestBuilder] set custom callLogs request builder
  final CallLogRequestBuilder? callLogsRequestBuilder;

  ///[timePattern] custom time pattern visible in callLogs
  final String? timePattern;

  ///[dateSeparatorPattern] pattern for  date separator
  final String? dateSeparatorPattern;

  ///[hideSeparator] toggle visibility of separator
  final bool? hideSeparator;

  ///[onItemClick] callback triggered on clicking of the callLog item
  final Function(CallLog callLog)? onItemClick;

  ///[callLogHistoryStyle] style for every call logs
  final CallLogHistoryStyle? callLogHistoryStyle;

  ///[callLogDetailConfiguration] used to set the configuration properties of [CometChatCallLogDetails]
  final CallLogDetailsConfiguration? callLogDetailConfiguration;

  @override
  State<CometChatCallLogHistory> createState() => _CometChatCallLogHistoryState();
}

class _CometChatCallLogHistoryState extends State<CometChatCallLogHistory> {
  CometChatCallLogHistoryController? cometChatCallLogHistoryController;
  late CometChatTheme _theme;

  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? cometChatTheme;
    initialize();
  }

  void initialize() async {
    String? userAuthToken = await CometChatUIKitCalls.getUserAuthToken();
    loggedInUser = await CometChat.getLoggedInUser();
    if (loggedInUser != null) {
      cometChatCallLogHistoryController = CometChatCallLogHistoryController(
        callLogsBuilderProtocol: widget.callLogsBuilderProtocol ??
            UICallLogsBuilder(widget.callLogsRequestBuilder ??
                CallLogRequestBuilder()
              ..authToken = userAuthToken
              ..callCategory = CometChatCallsConstants.callCategoryCall
              ..uid = (widget.callUser != null) ? widget.callUser?.uid : null
              ..guid =
                  (widget.callGroup != null) ? widget.callGroup?.guid : null),
        onError: widget.onError,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (cometChatCallLogHistoryController == null)
        ? const Scaffold()
        : CometChatListBase(
            title: widget.title ?? cc.Translations.of(context).call_history,
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
              background: (widget.callLogHistoryStyle?.gradient == null)
                  ? widget.callLogHistoryStyle?.background
                  : Colors.transparent,
              titleStyle: widget.callLogHistoryStyle?.titleStyle ??
                  TextStyle(
                    fontSize: _theme.typography.heading.fontSize,
                    fontWeight: _theme.typography.heading.fontWeight,
                    color: _theme.palette.getAccent(),
                  ),
              gradient: widget.callLogHistoryStyle?.gradient,
              height: widget.callLogHistoryStyle?.height,
              width: widget.callLogHistoryStyle?.width,
              backIconTint: widget.callLogHistoryStyle?.backIconTint ??
                  _theme.palette.getPrimary(),
              border: widget.callLogHistoryStyle?.border,
              borderRadius: widget.callLogHistoryStyle?.borderRadius,
            ),
            container: GetBuilder(
              init: cometChatCallLogHistoryController,
              builder: (CometChatCallLogHistoryController controller) {
                if (controller.hasError == true) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _showError(controller, context, _theme));
                  if (widget.errorStateView != null) {
                    return widget.errorStateView!(context);
                  }
                  return _getLoadingIndicator(context, _theme);
                } else if (controller.isLoading == true &&
                    controller.list.isEmpty) {
                  return _getLoadingIndicator(context, _theme);
                } else {
                  return (controller.list.isEmpty)
                      ? _emptyView(context, _theme)
                      : ListView.separated(
                          itemCount: controller.hasMoreItems
                              ? controller.groupedEntries.length + 1
                              : controller.groupedEntries.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == controller.groupedEntries.length) {
                              controller.loadMoreElements();
                              return _getLoadingIndicator(context, _theme);
                            }
                            if (controller.groupedEntries.isEmpty) {
                              return _emptyView(context, _theme);
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CallLogsUtils.getDateTimeTitle(
                                    _theme,
                                    controller.groupedEntries,
                                    index,
                                    widget.dateSeparatorPattern,
                                    widget.callLogHistoryStyle?.dateTextStyle,
                                    context),
                                ListView.builder(
                                  itemCount: CallLogsUtils.returnCallLogList(
                                    controller.groupedEntries,
                                    index,
                                  ).length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    final log = CallLogsUtils.returnCallLogList(
                                      controller.groupedEntries,
                                      index,
                                    )[i];
                                    return _defaultListItemView(
                                        log, controller, context, _theme);
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return (widget.hideSeparator == true)
                                ? const SizedBox()
                                : Divider(
                                    color: widget
                                            .callLogHistoryStyle?.dividerTint ??
                                        _theme.palette.getAccent500(),
                                  );
                          },
                        );
                }
              },
            ),
          );
  }

  // list view
  _defaultListItemView(CallLog log, CometChatCallLogHistoryController controller,
      BuildContext context, CometChatTheme theme) {
    if (widget.listItemView != null) {
      return widget.listItemView!(log, context);
    } else {
      return ListTile(
        contentPadding: const EdgeInsets.only(left: 0),
        minVerticalPadding: 0,
        dense: true,
        onTap: () {
          if (widget.onItemClick != null) {
            widget.onItemClick!(log);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CometChatCallLogDetails(
                  callLog: log,
                  showBackButton:
                      widget.callLogDetailConfiguration?.showBackButton,
                  onError: widget.callLogDetailConfiguration?.onError,
                  onBack: widget.callLogDetailConfiguration?.onBack,
                  backButton: widget.callLogDetailConfiguration?.backButton,
                  title: widget.callLogDetailConfiguration?.title,
                  theme: widget.callLogDetailConfiguration?.theme,
                  avatarStyle: widget.callLogDetailConfiguration?.avatarStyle,
                  callLogHistoryConfiguration: widget
                      .callLogDetailConfiguration?.callLogHistoryConfiguration,
                  customProfileView:
                      widget.callLogDetailConfiguration?.customProfileView,
                  data: widget.callLogDetailConfiguration?.data,
                  detailStyle: widget.callLogDetailConfiguration?.detailStyle,
                  participantsConfiguration: widget
                      .callLogDetailConfiguration?.participantsConfiguration,
                  recordingsConfiguration: widget
                      .callLogDetailConfiguration?.recordingsConfiguration,
                  stateCallBack:
                      widget.callLogDetailConfiguration?.stateCallBack,
                  callButtonsConfiguration: widget
                      .callLogDetailConfiguration?.callButtonsConfiguration,
                ),
              ),
            );
          }
        },
        title: Row(
          children: [
            CallLogsUtils.getTime(
              theme,
              widget.callLogHistoryStyle?.statusTextStyle,
              context,
              log.initiatedAt,
              datePattern: widget.timePattern,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              CallUtils.getStatus(context, log, controller.loggedInUser),
              style: widget.callLogHistoryStyle?.statusTextStyle ??
                  TextStyle(
                    fontSize: _theme.typography.title2.fontSize,
                    fontWeight: _theme.typography.heading.fontWeight,
                    color: _theme.palette.getAccent700(),
                  ),
            ),
          ],
        ),
        titleTextStyle: widget.callLogHistoryStyle?.titleStyle ??
            TextStyle(
              fontSize: _theme.typography.heading.fontSize,
              fontWeight: _theme.typography.heading.fontWeight,
              color: _theme.palette.getAccent700(),
            ),
        trailing: _getTailView(log, context, _theme),
      );
    }
  }

  // tail vIew
  _getTailView(CallLog callLog, BuildContext context, CometChatTheme theme) {
    if (widget.tailView != null) {
      return widget.tailView!(callLog, context);
    } else {
      return Text(
        CallLogsUtils.formatMinutesAndSeconds(
          callLog.totalDurationInMinutes ?? 0.0,
        ),
        style: widget.callLogHistoryStyle?.durationTextStyle ??
            TextStyle(
              fontSize: theme.typography.subtitle1.fontSize,
              fontWeight: theme.typography.heading.fontWeight,
              color: theme.palette.getAccent400(),
            ),
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
          color: widget.callLogHistoryStyle?.loadingIconTint ??
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
          style: widget.callLogHistoryStyle?.emptyTextStyle ??
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
  _showError(controller, BuildContext context, CometChatTheme theme) {
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

  // Show Error dialog
  _showErrorDialog(String errorText, BuildContext context, CometChatTheme theme,
      CometChatCallLogHistoryController controller) {
    showCometChatConfirmDialog(
      context: context,
      messageText: Text(
        widget.errorStateText ?? errorText,
        style: widget.callLogHistoryStyle?.errorTextStyle ??
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
