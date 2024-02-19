import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as cc;

///[CometChatCallLogDetails] is a mediator component that provides access to
///components for viewing profile, call status, participants, history and recordings if the [CometChatCallLogDetails] component is being shown for a [CallGroup]
///and options for video and audio call if the [CometChatCallLogDetails] component for a [CallUser]
///```dart
/// CometChatCallLogDetails(
///  callLog: callLog,
///  theme: theme,
///  title: "Call Details",
///  detailStyle: CallLogDetailsStyle(),
///  showBackButton: true,
///  backButton: Image.asset(
///  AssetConstants.back,
///  package: UIConstants.packageName,
///  color: theme.palette.getPrimary(),
///  ),
///  avatarStyle: AvatarStyle(),
///  )
///  ```
class CometChatCallLogDetails extends StatelessWidget {
  CometChatCallLogDetails({
    Key? key,
    required this.callLog,
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
    this.callButtonsConfiguration,
    this.datePattern,
    this.separatorDatePattern,
    this.arrowIcon,
    this.outgoingCallConfiguration,
    OnError? onError,
    void Function(CometChatCallLogDetailsController)? stateCallBack,
    List<CometChatCallLogDetailsTemplate>? Function(CallLog? callLog)? data,
  })  : _cometChatCallDetailsController = CometChatCallLogDetailsController(
          callLog: callLog,
          stateCallBack: stateCallBack,
          data: data,
          theme: theme,
          callHistoryConfiguration: callLogHistoryConfiguration,
          participantsConfiguration: participantsConfiguration,
          recordingsConfiguration: recordingsConfiguration,
          datePattern: datePattern,
          arrowIcon: arrowIcon,
          callButtonsConfiguration: callButtonsConfiguration,
          detailsStyle: detailStyle,
          separatorDatePattern: separatorDatePattern,
          outgoingCallConfiguration: outgoingCallConfiguration,
        ),
        super(key: key);

  /// [callLog] object for CallLog Detail
  final CallLog callLog;

  /// [theme] to set custom theme
  final CometChatTheme? theme;

  ///to pass [CometChatDetails] header text use [title]
  final String? title;

  ///[detailStyle] is used to pass styling properties
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

  ///[separatorDatePattern] custom date pattern
  final String? separatorDatePattern;

  ///[datePattern] custom date pattern
  final String? datePattern;

  ///[arrowIcon] to set custom icon
  final String? arrowIcon;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final OutgoingCallConfiguration? outgoingCallConfiguration;

  final CometChatCallLogDetailsController _cometChatCallDetailsController;

  Widget _getOption(
      int index,
      BuildContext context,
      String sectionId,
      CometChatCallLogDetailsController callDetailsController,
      CometChatTheme theme) {
    CometChatCallLogDetailsOption? option =
        _cometChatCallDetailsController.optionsMap[sectionId]?[index];
    if (option != null) {
      return option.customView ??
          SizedBox(
            height: option.height ?? 56,
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => _cometChatCallDetailsController.useOption(
                    option, sectionId),
                title: Text(
                  option.title ?? "",
                  style: option.titleStyle ??
                      TextStyle(
                          fontFamily: theme.typography.name.fontFamily,
                          fontWeight: theme.typography.name.fontWeight,
                          color: sectionId ==
                                  DetailsTemplateConstants.secondaryActions
                              ? theme.palette.getError()
                              : theme.palette.getPrimary()),
                ),
                trailing: option.tail,
              ),
            ),
          );
    }
    return const SizedBox();
  }

  _getProfile(BuildContext context, CometChatCallLogDetailsController controller,
      CometChatTheme theme) {
    return (controller.loggedInUser == null)
        ? const SizedBox()
        : Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CometChatAvatar(
                image: CallLogsUtils.receiverAvatar(
                    controller.loggedInUser, callLog),
                style: avatarStyle ??
                    AvatarStyle(
                        height: avatarStyle?.height ?? 100,
                        width: avatarStyle?.width ?? 100,
                        background: avatarStyle?.background,
                        border: avatarStyle?.border,
                        borderRadius: avatarStyle?.borderRadius,
                        gradient: avatarStyle?.gradient,
                        nameTextStyle: avatarStyle?.nameTextStyle,
                        outerBorderRadius: avatarStyle?.outerBorderRadius,
                        outerViewBackgroundColor:
                            avatarStyle?.outerViewBackgroundColor,
                        outerViewBorder: avatarStyle?.outerViewBorder,
                        outerViewSpacing: avatarStyle?.outerViewSpacing,
                        outerViewWidth: avatarStyle?.outerViewWidth),
                name: CallLogsUtils.receiverName(
                    controller.loggedInUser, callLog),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                CallLogsUtils.receiverName(controller.loggedInUser, callLog),
                style: TextStyle(
                  fontSize: theme.typography.heading.fontSize,
                  fontWeight: theme.typography.heading.fontWeight,
                  color: theme.palette.getAccent700(),
                ),
              ),
            ],
          );
  }

  // section view components------------------
  Widget _getSectionData(BuildContext context, int index,
      CometChatCallLogDetailsController detailsController, CometChatTheme theme) {
    CometChatCallLogDetailsTemplate template =
        detailsController.templateList[index];
    String sectionId = template.id;

    if (detailsController.optionsMap[sectionId] == null ||
        detailsController.optionsMap[sectionId]!.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          detailsController.optionsMap[sectionId]!.length,
          (index) =>
              _getOption(index, context, sectionId, detailsController, theme),
        ),
        if (template.hideSectionSeparator == true &&
            index != detailsController.templateList.length - 1)
          Divider(
            thickness: 1,
            color: theme.palette.getAccent100(),
          )
      ],
    );
  }

  _getListBaseChild(BuildContext context,
      CometChatCallLogDetailsController controller, CometChatTheme _theme) {
    controller.initializeSectionUtilities();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          customProfileView ?? _getProfile(context, controller, _theme),
          const SizedBox(
            height: 15,
          ),
          _getListOfSectionData(context, controller, _theme)
        ],
      ),
    );
  }

  Widget _getListOfSectionData(BuildContext context,
      CometChatCallLogDetailsController controller, CometChatTheme theme) {
    return Column(children: [
      ...List.generate(
        controller.templateList.length,
        (index) => _getSectionData(context, index, controller, theme),
      ),
      const SizedBox(
        height: 10,
      ),
      Divider(
        thickness: 1,
        color: theme.palette.getAccent100(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final CometChatTheme _theme = theme ?? cometChatTheme;
    return  CometChatListBase(
            title: title ?? cc.Translations.of(context).call_detail,
            hideSearch: true,
            backIcon: backButton ??
                Image.asset(
                  AssetConstants.back,
                  package: UIConstants.packageName,
                  color: _theme.palette.getAccent(),
                ),
            showBackButton: showBackButton ?? true,
            onBack: onBack ??
                () {
                  Navigator.of(context).pop();
                },
            style: ListBaseStyle(
              background: (detailStyle?.gradient == null)
                  ? detailStyle?.background
                  : Colors.transparent,
              titleStyle: detailStyle?.titleStyle ??
                  TextStyle(
                    fontSize: _theme.typography.heading.fontSize,
                    fontWeight: _theme.typography.heading.fontWeight,
                    color: _theme.palette.getAccent(),
                  ),
              gradient: detailStyle?.gradient,
              height: detailStyle?.height,
              width: detailStyle?.width,
              backIconTint:
                  detailStyle?.backIconTint ?? _theme.palette.getPrimary(),
              border: detailStyle?.border,
              borderRadius: detailStyle?.borderRadius,
            ),
            container: SizedBox(
              child: GetBuilder(
                init: _cometChatCallDetailsController,
                global: false,
                dispose:
                    (GetBuilderState<CometChatCallLogDetailsController> state) =>
                        state.controller?.onClose(),
                builder: (CometChatCallLogDetailsController detailsController) {
                  detailsController.context = context;
                  detailsController.theme = _theme;
                  return _getListBaseChild(context, detailsController, _theme);
                },
              ),
            ),
          );
  }
}
