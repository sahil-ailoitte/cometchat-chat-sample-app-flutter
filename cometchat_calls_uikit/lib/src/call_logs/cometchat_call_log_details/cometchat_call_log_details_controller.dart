import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';

class CometChatCallLogDetailsController extends GetxController
    implements CometChatCallLogDetailProtocolController {
  CometChatCallLogDetailsController({
    required this.callLog,
    this.data,
    this.stateCallBack,
    this.callHistoryConfiguration,
    this.recordingsConfiguration,
    this.participantsConfiguration,
    this.theme,
    this.callButtonsConfiguration,
    this.detailsStyle,
    this.separatorDatePattern,
    this.datePattern,
    this.arrowIcon,
    this.outgoingCallConfiguration,
  });

  CallLog callLog;
  late BuildContext context;
  late CometChatTheme? theme;

  User? loggedInUser;

  final List<CometChatCallLogDetailsTemplate>? Function(CallLog? callLog)? data;

  final void Function(CometChatCallLogDetailsController)? stateCallBack;

  ///[participantsConfiguration] for opening participants
  final CallLogParticipantsConfiguration? participantsConfiguration;

  ///[recordingsConfiguration] for opening recordings
  final CallLogRecordingsConfiguration? recordingsConfiguration;

  ///[callHistoryConfiguration] for viewing call History
  final CallLogHistoryConfiguration? callHistoryConfiguration;

  ///configurations for viewing group members
  final CallButtonsConfiguration? callButtonsConfiguration;

  ///configurations for viewing group members
  final CallLogDetailsStyle? detailsStyle;

  ///[separatorDatePattern] custom date pattern
  final String? separatorDatePattern;

  ///[datePattern] custom date pattern
  final String? datePattern;

  ///[arrowIcon] to set custom icon
  final String? arrowIcon;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final OutgoingCallConfiguration? outgoingCallConfiguration;

  List<CometChatCallLogDetailsTemplate> templateList = [];

  Map<String, List<CometChatCallLogDetailsOption>> optionsMap = {};

  @override
  void onInit() {
    if (stateCallBack != null) {
      stateCallBack!(this);
    }
    initializeLoggedInUser();
    super.onInit();
  }

  initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
    update();
  }

  @override
  useOption(CometChatCallLogDetailsOption _option, String sectionId) {
    if (_option.onClick != null) {
      debugPrint(
          "option clicked on ID is ${_option.id} and title is ${_option.title}");
      _option.onClick!(callLog, sectionId, this);
    }
  }

  initializeSectionUtilities() {
    if (data != null) {
      templateList = data!(callLog) ?? [];
    } else {
      templateList = CallLogDetailsUtils.getDefaultDetailsTemplates(
        context,
        loggedInUser,
        callButtonsConfiguration,
        detailsStyle,
        theme: theme,
        callLog: callLog,
        outgoingCallConfiguration: outgoingCallConfiguration,
        datePattern: datePattern,
        separatorDatePattern: separatorDatePattern,
        arrowIcon: arrowIcon,
      );
    }

    _setOptions();
  }

  //predefined template option functions end --------------------

  //Utility functions-------------

  //set options in option map after populating onClick
  _setOptions() {
    for (CometChatCallLogDetailsTemplate template in templateList) {
      optionsMap[template.id] = _getPopulatedOptions(template) ?? [];
    }
  }

  //returns list of detail options after populating default options if function is null
  List<CometChatCallLogDetailsOption>? _getPopulatedOptions(
      CometChatCallLogDetailsTemplate template) {
    List<CometChatCallLogDetailsOption>? options;
    if (template.options != null) {
      options = template.options!(callLog, context, theme);
    }

    //Getting initial option List
    //checking individual option if null then passing the new option
    if (options == null || options.isEmpty) return options;

    for (CometChatCallLogDetailsOption option in options) {
      option.onClick ??= _getOptionOnClick(option.id);
    }
    return options;
  }

  //returns default options according to option id
  Function(CallLog? callLog, String section,
          CometChatCallLogDetailProtocolController state)?
      _getOptionOnClick(String optionId) {
    switch (optionId) {
      case CallLogsConstants.participants:
        {
          return _participants;
        }
      case CallLogsConstants.recordings:
        {
          return _recordings;
        }
      case CallLogsConstants.callHistory:
        {
          return _callHistory;
        }
      default:
        {
          return null;
        }
    }
  }

  _participants(CallLog? log, String section,
      CometChatCallLogDetailProtocolController state) async {
    if (log != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CometChatCallLogParticipants(
            callLog: log,
            listItemView: participantsConfiguration?.listItemView,
            listItemStyle: participantsConfiguration?.listItemStyle,
            hideSeparator: participantsConfiguration?.hideSeparator,
            theme: participantsConfiguration?.theme,
            subTitleView: participantsConfiguration?.subTitleView,
            emptyStateView: participantsConfiguration?.emptyStateView,
            emptyStateText: participantsConfiguration?.emptyStateText,
            datePattern: participantsConfiguration?.datePattern,
            title: participantsConfiguration?.title,
            avatarStyle: participantsConfiguration?.avatarStyle,
            tailView: participantsConfiguration?.tailView,
            backButton: participantsConfiguration?.backButton,
            onBack: participantsConfiguration?.onBack,
            onError: participantsConfiguration?.onError,
            participantsStyle: participantsConfiguration?.participantsStyle,
            showBackButton: participantsConfiguration?.showBackButton,
          ),
        ),
      );
    }
  }

  _recordings(CallLog? log, String section,
      CometChatCallLogDetailProtocolController state) async {
    if (log != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CometChatCallLogRecordings(
            callLog: log,
            showBackButton: recordingsConfiguration?.showBackButton,
            onError: recordingsConfiguration?.onError,
            onBack: recordingsConfiguration?.onBack,
            backButton: recordingsConfiguration?.backButton,
            tailView: recordingsConfiguration?.tailView,
            title: recordingsConfiguration?.title,
            datePattern: recordingsConfiguration?.datePattern,
            emptyStateText: recordingsConfiguration?.emptyStateText,
            emptyStateView: recordingsConfiguration?.emptyStateView,
            hideSeparator: recordingsConfiguration?.hideSeparator,
            listItemView: recordingsConfiguration?.listItemView,
            theme: recordingsConfiguration?.theme,
            downloadIconUrl: recordingsConfiguration?.downloadIconUrl,
            onDownloadClick: recordingsConfiguration?.onDownloadClick,
            recordingsStyle: recordingsConfiguration?.recordingsStyle,
            subTitleView: recordingsConfiguration?.subTitleView,
          ),
        ),
      );
    }
  }

  _callHistory(CallLog? log, String section,
      CometChatCallLogDetailProtocolController state) async {
    CallUser? callUser;
    CallGroup? callGroup;
    if (log != null) {
      if (CallLogsUtils.isUser(log)) {
        callUser = CallUser(
          name: CallLogsUtils.receiverName(loggedInUser, log),
          uid: CallLogsUtils.returnReceiverId(loggedInUser, log),
          avatar: CallLogsUtils.receiverAvatar(loggedInUser, log),
        );
      } else if (log.receiver != null && log.receiver is CallGroup) {
        callGroup = log.receiver as CallGroup;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CometChatCallLogHistory(
            callUser: callUser,
            callGroup: callGroup,
            theme: callHistoryConfiguration?.theme,
            listItemView: callHistoryConfiguration?.listItemView,
            hideSeparator: callHistoryConfiguration?.hideSeparator,
            emptyStateView: callHistoryConfiguration?.emptyStateView,
            emptyStateText: callHistoryConfiguration?.emptyStateText,
            timePattern: callHistoryConfiguration?.emptyStateText,
            title: callHistoryConfiguration?.title,
            tailView: callHistoryConfiguration?.tailView,
            backButton: callHistoryConfiguration?.backButton,
            onBack: callHistoryConfiguration?.onBack,
            onError: callHistoryConfiguration?.onError,
            showBackButton: callHistoryConfiguration?.showBackButton,
            loadingStateView: callHistoryConfiguration?.loadingStateView,
            loadingIconUrl: callHistoryConfiguration?.loadingIconUrl,
            errorStateView: callHistoryConfiguration?.errorStateView,
            errorStateText: callHistoryConfiguration?.errorStateText,
            dateSeparatorPattern:
                callHistoryConfiguration?.dateSeparatorPattern,
            callLogsRequestBuilder:
                callHistoryConfiguration?.callLogsRequestBuilder,
            callLogsBuilderProtocol:
                callHistoryConfiguration?.callLogsBuilderProtocol,
            callLogHistoryStyle: callHistoryConfiguration?.callLogHistoryStyle,
            onItemClick: callHistoryConfiguration?.onItemClick,
            callLogDetailConfiguration:
                callHistoryConfiguration?.callLogDetailsConfiguration,
          ),
        ),
      );
    }
  }

  @override
  int removeOption(String templateId, String optionId) {
    int actionIndex = -1;
    if (optionsMap[templateId] != null) {
      int? optionIndex = optionsMap[templateId]
          ?.indexWhere((element) => (element.id == optionId));
      if (optionIndex != null && optionIndex != -1) {
        optionsMap[templateId]!.removeAt(optionIndex);
        actionIndex = optionIndex;
        update();
      }
    }
    return actionIndex;
  }

  @override
  int addOption(String templateId, CometChatCallLogDetailsOption newOption,
      {int? position}) {
    int actionIndex = -1;
    if (optionsMap[templateId] != null) {
      if (position != null && position < optionsMap[templateId]!.length) {
        optionsMap[templateId]!.insert(position, newOption);
        actionIndex = position;
      } else {
        optionsMap[templateId]!.add(newOption);
        actionIndex = optionsMap[templateId]!.length;
      }

      update();
    }
    return actionIndex;
  }

  @override
  Map<String, List<CometChatCallLogDetailsOption>> getDetailsOptionMap() {
    return optionsMap;
  }

  @override
  List<CometChatCallLogDetailsTemplate> getDetailsTemplateList() {
    return templateList;
  }

  @override
  int updateOption(String templateId, String oldOptionID,
      CometChatCallLogDetailsOption updatedOption) {
    int actionIndex = -1;
    if (optionsMap[templateId] != null) {
      int? optionIndex = optionsMap[templateId]
          ?.indexWhere((element) => (element.id == oldOptionID));
      if (optionIndex != null && optionIndex != -1) {
        updatedOption.onClick ??= _getOptionOnClick(updatedOption.id);
        optionsMap[templateId]![optionIndex] = updatedOption;
        update();
        actionIndex = optionIndex;
      }
    }
    return actionIndex;
  }
}
