import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:get/get.dart';

///[CometChatCallLogsWithDetails] is a component that displays a list of call recordings with the help of [CometChatListBase] and [CometChatListItem]
///
///
/// ```dart
///   CometChatCallLogsWithDetail(
///   callLogsConfiguration: CallLogsConfiguration(),
///   callLogDetailConfiguration: CallDetailsConfiguration(),
/// );
/// `
class CometChatCallLogsWithDetails extends StatelessWidget {
  CometChatCallLogsWithDetails({
    Key? key,
    this.theme,
    this.callLogsConfiguration,
    this.callLogDetailConfiguration,
  })  : _cometChatCallLogWithDetailController =
            CometChatCallLogsWithDetailsController(),
        super(key: key);

  ///[callLogsConfiguration] used to set the configuration properties of [CometChatCallLogs]
  final CallLogsConfiguration? callLogsConfiguration;

  ///[callLogDetailConfiguration] used to set the configuration properties of [CometChatCallLogDetails]
  final CallLogDetailsConfiguration? callLogDetailConfiguration;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;

  final CometChatCallLogsWithDetailsController
      _cometChatCallLogWithDetailController;

  _getTailView(CallLog callLog, BuildContext context, CometChatTheme theme,
      CometChatCallLogsWithDetailsController controller) {
    final CometChatTheme theme = this.theme ?? cometChatTheme;
    if (callLogsConfiguration?.tailView != null) {
      return callLogsConfiguration?.tailView!(context, callLog);
    }
    return SizedBox(
      height: callLogsConfiguration?.callLogsStyle?.height,
      width: callLogsConfiguration?.callLogsStyle?.width ?? 130,
      child: Row(
        children: [
          Expanded(
            child: CallLogsUtils.getTime(
              theme,
              callLogsConfiguration?.callLogsStyle?.tailTitleStyle,
              context,
              callLog.initiatedAt,
              datePattern: callLogsConfiguration?.datePattern,
            ),
          ),
          IconButton(
            onPressed: () {
              if (callLogsConfiguration?.onInfoIconClick != null) {
                callLogsConfiguration?.onInfoIconClick!(callLog);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CometChatCallLogDetails(
                      callLog: callLog,
                      showBackButton:
                          callLogDetailConfiguration?.showBackButton,
                      onError: callLogDetailConfiguration?.onError,
                      onBack: callLogDetailConfiguration?.onBack,
                      backButton: callLogDetailConfiguration?.backButton,
                      title: callLogDetailConfiguration?.title,
                      theme: callLogDetailConfiguration?.theme,
                      avatarStyle: callLogDetailConfiguration?.avatarStyle,
                      callLogHistoryConfiguration: callLogDetailConfiguration
                          ?.callLogHistoryConfiguration,
                      customProfileView:
                          callLogDetailConfiguration?.customProfileView,
                      data: callLogDetailConfiguration?.data,
                      detailStyle: callLogDetailConfiguration?.detailStyle,
                      participantsConfiguration:
                          callLogDetailConfiguration?.participantsConfiguration,
                      recordingsConfiguration:
                          callLogDetailConfiguration?.recordingsConfiguration,
                      stateCallBack: callLogDetailConfiguration?.stateCallBack,
                      callButtonsConfiguration:
                          callLogDetailConfiguration?.callButtonsConfiguration,
                      datePattern: callLogDetailConfiguration?.datePattern,
                      separatorDatePattern:
                          callLogDetailConfiguration?.separatorDatePattern,
                      arrowIcon: callLogDetailConfiguration?.arrowIcon,
                      outgoingCallConfiguration:
                          callLogDetailConfiguration?.outgoingCallConfiguration,
                    ),
                  ),
                );
              }
            },
            icon: Image.asset(
              callLogsConfiguration?.infoIconUrl ?? AssetConstants.info,
              package: UIConstants.packageName,
              color: callLogsConfiguration?.callLogsStyle?.infoIconTint ??
                  theme.palette.getAccent600(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _cometChatCallLogWithDetailController,
      global: false,
      dispose: (GetBuilderState<CometChatCallLogsWithDetailsController> state) =>
          state.controller?.onClose(),
      builder: (CometChatCallLogsWithDetailsController controller) {
        return CometChatCallLogs(
          tailView: (context, callLog) => _getTailView(
              callLog, context, theme ?? cometChatTheme, controller),
          avatarStyle: callLogsConfiguration?.avatarStyle,
          theme: callLogsConfiguration?.theme,
          title: callLogsConfiguration?.title,
          backButton: callLogsConfiguration?.backButton,
          callLogsBuilderProtocol:
              callLogsConfiguration?.callLogsBuilderProtocol,
          callLogsRequestBuilder: callLogsConfiguration?.callLogsRequestBuilder,
          callLogsStyle: callLogsConfiguration?.callLogsStyle,
          datePattern: callLogsConfiguration?.datePattern,
          dateSeparatorPattern: callLogsConfiguration?.dateSeparatorPattern,
          emptyStateText: callLogsConfiguration?.emptyStateText,
          emptyStateView: callLogsConfiguration?.emptyStateView,
          errorStateText: callLogsConfiguration?.errorStateText,
          errorStateView: callLogsConfiguration?.errorStateView,
          hideSeparator: callLogsConfiguration?.hideSeparator,
          infoIconUrl: callLogsConfiguration?.infoIconUrl,
          listItemStyle: callLogsConfiguration?.listItemStyle,
          listItemView: callLogsConfiguration?.listItemView,
          loadingIconUrl: callLogsConfiguration?.loadingIconUrl,
          loadingStateView: callLogsConfiguration?.loadingStateView,
          outgoingCallConfiguration:
              callLogsConfiguration?.outgoingCallConfiguration,
          onError: callLogsConfiguration?.onError,
          onBack: callLogsConfiguration?.onBack,
          onInfoIconClick: callLogsConfiguration?.onInfoIconClick,
          onItemClick: callLogsConfiguration?.onItemClick,
          showBackButton: callLogsConfiguration?.showBackButton,
          subTitleView: callLogsConfiguration?.subTitleView,
          incomingAudioCallIcon: callLogsConfiguration?.incomingAudioCallIcon,
          incomingVideoCallIcon: callLogsConfiguration?.incomingVideoCallIcon,
          missedAudioCallIcon: callLogsConfiguration?.missedAudioCallIcon,
          missedVideoCallIcon: callLogsConfiguration?.missedVideoCallIcon,
          outgoingAudioCallIcon: callLogsConfiguration?.outgoingAudioCallIcon,
          outgoingVideoCallIcon: callLogsConfiguration?.outgoingVideoCallIcon,
        );
      },
    );
  }
}
