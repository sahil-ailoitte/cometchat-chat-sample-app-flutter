
import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CallingExtensionDecorator] is a the view model for [CometChatCallingExtension] it contains all the relevant business logic
///it is also a sub-class of [DataSourceDecorator] which allows any extension to override the default methods provided by [MessagesDataSource]
class CallingExtensionDecorator extends DataSourceDecorator
    with
        CallListener,
        CometChatCallEventListener
{
  ///[callingTypeConstant] is a constant used to identify the extension
  String callingTypeConstant = 'calling';

  ///[configuration] is a [CallingConfiguration] object which contains all the configuration required for the extension
  CallingConfiguration? configuration;

  ///[_loggedInUser] is a [User] object which contains the details of the logged in user
  User? _loggedInUser;

  BaseMessage? activeCall;

  final String _listenerId = "CallingExtensionDecorator";

  ///[CallingExtensionDecorator] constructor requires [DataSource] and [CallingConfiguration] as a parameter
  CallingExtensionDecorator(
    DataSource dataSource, {
    this.configuration,
  }) : super(dataSource) {
    //[_initializeDependencies] method is called to initialize all the dependencies required for the extension
    _initializeDependencies();
    // [addListeners] method is called to add listeners for the extension
    addListeners();
  }

  ///[_initializeDependencies] method is used to initialize all the dependencies required for the extension
  _initializeDependencies() async {
    //[_loggedInUser] is initialized with the logged in user
    _loggedInUser = await CometChatUIKit.getLoggedInUser();
    UIKitSettings? authenticationSettings =
        CometChatUIKit.authenticationSettings;
    //we are initializing the calling sdk with the appId and region if authenticationSettings are not null
    if (authenticationSettings != null &&
        authenticationSettings.appId != null &&
        authenticationSettings.region != null) {
      CometChatUIKitCalls.init(
          authenticationSettings.appId!, authenticationSettings.region!);
    }
  }

  ///[addListeners] method is used to register the call listeners
  void addListeners() {
    CometChat.addCallListener(_listenerId, this);
    CometChatCallEvents.addCallEventsListener(_listenerId, this);
  }

  ///[getId] method is used to get the string identifier for the extension
  @override
  String getId() {
    return callingTypeConstant;
  }

  ///[getAllMessageTypes] method is used to get all the message types present in [MessagesDataSource]
  @override
  List<String> getAllMessageTypes() {
    List<String> messageTypes = super.getAllMessageTypes();
    if(!messageTypes.contains(MessageTypeConstants.audio)) {
      messageTypes.add(MessageTypeConstants.audio);
    }
    if(!messageTypes.contains(MessageTypeConstants.video)) {
      messageTypes.add(MessageTypeConstants.video);
    }
    if(!messageTypes.contains(CallExtensionConstants.meeting)) {
      messageTypes.add(CallExtensionConstants.meeting);
    }
    return messageTypes;
  }

  ///[getAllMessageCategories] method is used to get all the message categories present in [MessagesDataSource]
  @override
  List<String> getAllMessageCategories() {
    List<String> categories = super.getAllMessageCategories();
    if(!categories.contains(MessageCategoryConstants.call)) {
      categories.add(MessageCategoryConstants.call);
    }
    if(!categories.contains(MessageCategoryConstants.custom)) {
      categories.add(MessageCategoryConstants.custom);
    }
    return categories;
  }

  ///[getAllMessageTemplates] method is used to get all the message templates present in [MessagesDataSource]
  @override
  List<CometChatMessageTemplate> getAllMessageTemplates(
      {CometChatTheme? theme}) {
    List<CometChatMessageTemplate> templates = super.getAllMessageTemplates();
    templates.add(getMeetWorkflowTemplate(theme: theme));
    templates.add(getDefaultVoiceCallTemplate(theme: theme));
    templates.add(getDefaultVideoCallTemplate(theme: theme));
    return templates;
  }

  ///[getMeetWorkflowTemplate] method is used to get the template for conference call
  CometChatMessageTemplate getMeetWorkflowTemplate({CometChatTheme? theme}) {
    return CometChatMessageTemplate(
      type: CallExtensionConstants.meeting,
      category: MessageCategoryConstants.custom,
      options: ChatConfigurator.getDataSource().getCommonOptions,
      bottomView: ChatConfigurator.getDataSource().getBottomView,
      contentView: (BaseMessage message, BuildContext context,
          BubbleAlignment alignment) {
        //checking if the theme is null or not
        CometChatTheme availableTheme = theme ?? cometChatTheme;

        //checking if the message is deleted or not
        if (message.deletedAt != null) {
          return super.getDeleteMessageBubble(message, availableTheme);
        } else {
          String title;

          //checking if the message is sent by the logged in user or not
          if (message.sender?.uid == _loggedInUser?.uid) {
            title = Translations.of(context).you_initiated_group_call;
          } else {
            title =
                "${message.sender?.name} ${Translations.of(context).initiated_group_call}";
          }

          Color? titleColor;
          Color? iconTint;
          Color? backgroundColor;
          if (alignment == BubbleAlignment.left) {
            titleColor = availableTheme.palette.getAccent();
            iconTint = availableTheme.palette.getPrimary();
            backgroundColor = cometChatTheme.palette.mode==PaletteThemeModes.light?availableTheme.palette.getAccent50() : availableTheme.palette.getAccent100();
          } else if (alignment == BubbleAlignment.right) {
            titleColor = availableTheme.palette.backGroundColor.light;
            iconTint = availableTheme.palette.backGroundColor.light;
            backgroundColor = availableTheme.palette.getPrimary();
          }

          String receiver = message.receiverUid;

          return CometChatCallBubble(
            title: configuration?.callBubbleConfiguration?.title ?? title,
            onTap: configuration?.callBubbleConfiguration?.onTap ?? (context) =>initiateDirectCall(context, receiver,call: Call(receiverUid: receiver, receiverType: CometChatReceiverType.group, category: MessageCategoryConstants.call,type:CallExtensionConstants.meeting )),
            callBubbleStyle: CallBubbleStyle(
              titleStyle: TextStyle(
                  color: titleColor,
                  fontSize: availableTheme.typography.name.fontSize,
                  fontWeight: availableTheme.typography.name.fontWeight),
              iconTint: iconTint,
              background: backgroundColor,
            ).merge(configuration?.callBubbleConfiguration?.callBubbleStyle),
            alignment: configuration?.callBubbleConfiguration?.alignment ?? alignment,
            theme: configuration?.callBubbleConfiguration?.theme ?? availableTheme,
            buttonText:  configuration?.callBubbleConfiguration?.buttonText,
            icon: configuration?.callBubbleConfiguration?.icon,
          );
        }
      },
    );
  }

  ///[initiateDirectCall] will initiate a direct call
  void initiateDirectCall(BuildContext context, String sessionId,{Call? call}) async {
    MainVideoContainerSetting videoSettings =
    MainVideoContainerSetting();
    videoSettings.setMainVideoAspectRatio("contain");
    videoSettings.setNameLabelParams("top-left", true, "#000");
    videoSettings.setZoomButtonParams("top-right", true);
    videoSettings.setUserListButtonParams("top-left", true);
    videoSettings.setFullScreenButtonParams("top-right", true);

    CallSettingsBuilder callSettingsBuilder = (CallSettingsBuilder()
      ..enableDefaultLayout = true
      ..setMainVideoContainerSetting = videoSettings);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CometChatOngoingCall(
            callSettingsBuilder: configuration?.ongoingCallConfiguration?.callSettingsBuilder ??  callSettingsBuilder,
            sessionId: sessionId,
              callWorkFlow: CallWorkFlow.directCalling,
            onError: configuration?.ongoingCallConfiguration?.onError,
          ),
        ));
  }

  ///[getDefaultVoiceCallTemplate] method is used to get the template for default voice calling
  CometChatMessageTemplate getDefaultVoiceCallTemplate(
      {CometChatTheme? theme}) {
    return CometChatMessageTemplate(
      type: CallTypeConstants.audioCall,
      category: MessageCategoryConstants.call,
      footerView: null,
      contentView: (BaseMessage message, BuildContext context,
          BubbleAlignment alignment) {
        // return MessageBubbleUtils.getActionContentView(context, getActionMessageCall(context, baseMessage), null, new TextBubbleStyle().setBackground(context.getResources().getDrawable(R.drawable.action_dotted_border)).setTextAppearance(theme.getTypography().getCaption1()).setTextColor(theme.getPalette().getAccent()));

        if (message is Call) {
          CometChatTheme availableTheme = theme ?? cometChatTheme;

          bool isMissedCall =
              CallUtils.isMissedCall(message, _loggedInUser);
          return CometChatGroupActionBubble(
            text: CallUtils.getCallStatus(context, message, _loggedInUser),
            leadingIcon: Image.asset(
              AssetConstants.audioCall,
              package: UIConstants.packageName,
              color: isMissedCall == true
                  ? availableTheme.palette.getError()
                  :  availableTheme.palette.getAccent(),
            ),
            style: GroupActionBubbleStyle(
                textStyle: TextStyle(
                  fontSize: availableTheme.typography.caption1.fontSize,
                  fontWeight: availableTheme.typography.caption1.fontWeight,
                  color: isMissedCall == true
                      ? availableTheme.palette.getError()
                      :  availableTheme.palette.getAccent(),
                ),
                background: availableTheme.palette.getBackground()),
            theme: availableTheme,
          );
        } else {
          return null;
        }
      },
    );
  }

  ///[getDefaultVideoCallTemplate] method is used to get the template for default video calling
  CometChatMessageTemplate getDefaultVideoCallTemplate(
      {CometChatTheme? theme}) {
    return CometChatMessageTemplate(
      type: CallTypeConstants.videoCall,
      category: MessageCategoryConstants.call,
      contentView: (BaseMessage message, BuildContext context,
          BubbleAlignment alignment) {
        // return MessageBubbleUtils.getActionContentView(context, getActionMessageCall(context, baseMessage), null, new TextBubbleStyle().setBackground(context.getResources().getDrawable(R.drawable.action_dotted_border)).setTextAppearance(theme.getTypography().getCaption1()).setTextColor(theme.getPalette().getAccent()));
        if (message is Call) {
          CometChatTheme availableTheme = theme ?? cometChatTheme;

          bool isMissedCall =
              CallUtils.isMissedCall(message, _loggedInUser);
          return CometChatGroupActionBubble(
            text: CallUtils.getCallStatus(context, message, _loggedInUser),
            leadingIcon: Image.asset(
              AssetConstants.videoCall,
              package: UIConstants.packageName,
              color: isMissedCall == true
                  ? availableTheme.palette.getError()
                  :  availableTheme.palette.getAccent(),
            ),
            style: GroupActionBubbleStyle(
                textStyle: TextStyle(
                  fontSize: availableTheme.typography.caption1.fontSize,
                  fontWeight: availableTheme.typography.caption1.fontWeight,
                  color: isMissedCall
                      ? availableTheme.palette.getError()
                      : availableTheme.palette.getAccent(),
                ),
                background: availableTheme.palette.getBackground()),
            theme: availableTheme
          );
        } else {
          return null;
        }
      },
    );
  }

  ///[getLastConversationMessage] method is used to set an appropriate subtitle in the [CometChatListItem]
  ///displayed in [CometChatConversations] the last message of conversation
  @override
  String getLastConversationMessage(
      Conversation conversation, BuildContext context) {
    BaseMessage? lastMessage = conversation.lastMessage;
    if (lastMessage != null) {
      String? message;
      if (lastMessage.category == MessageCategoryConstants.call) {
        if (lastMessage is Call) {
          if (!CallUtils.isVideoCall(lastMessage)) {
            message = "📞 ${CallUtils.getCallStatus(context, lastMessage, _loggedInUser)}";
          } else {
            message = "📹 ${CallUtils.getCallStatus(context, lastMessage, _loggedInUser)}";
          }
          return message;
        }
      } else if (lastMessage.category == MessageCategoryConstants.custom &&
          lastMessage.category == CallExtensionConstants.meeting) {
        message = CallUtils.getLastMessageForGroupCall(
            lastMessage, context, _loggedInUser);
        return message;
      }
    }

    return super.getLastConversationMessage(conversation, context);
  }

  ///[getAuxiliaryHeaderMenu] method is used to set a custom header menu to be displayed in [CometChatMessageHeader]
  @override
  Widget? getAuxiliaryHeaderMenu(
      BuildContext context, User? user, Group? group, CometChatTheme? theme) {
    //retrieve the contents of the header menu from the data source.
    Widget? currentHeaderMenu =
        dataSource.getAuxiliaryHeaderMenu(context, user, group, theme);

    //initializing an empty list of widgets.
    List<Widget> menuItems = [];

    //adding the call buttons to the list of widgets to be displayed in the header menu.
    menuItems.add(CometChatCallButtons(
      user: user,
      group: group,
      videoCallIconURL: configuration?.callButtonsConfiguration?.videoCallIconURL ?? AssetConstants.videoCall,
      voiceCallIconURL: configuration?.callButtonsConfiguration?.voiceCallIconURL ?? AssetConstants.audioCall,
      videoCallIconHoverText:configuration?.callButtonsConfiguration?.videoCallIconHoverText ?? Translations.of(context).video_call,
      voiceCallIconHoverText: configuration?.callButtonsConfiguration?.voiceCallIconHoverText ?? Translations.of(context).voice_call,
      callButtonsStyle: CallButtonsStyle(
        videoCallIconTint: cometChatTheme.palette.getPrimary(),
        voiceCallIconTint: cometChatTheme.palette.getPrimary(),
        background: cometChatTheme.palette.getBackground(),
      ).merge(configuration?.callButtonsConfiguration?.callButtonsStyle),
      onError: configuration?.callButtonsConfiguration?.onError,
      onVideoCallClick: configuration?.callButtonsConfiguration?.onVideoCallClick,
      onVoiceCallClick: configuration?.callButtonsConfiguration?.onVoiceCallClick,
      outgoingCallConfiguration: configuration?.callButtonsConfiguration?.outgoingCallConfiguration,
      videoCallIconPackage: configuration?.callButtonsConfiguration?.videoCallIconPackage ,
      videoCallIconText: configuration?.callButtonsConfiguration?.videoCallIconText,
      voiceCallIconText: configuration?.callButtonsConfiguration?.voiceCallIconText,
      voiceCallIconPackage: configuration?.callButtonsConfiguration?.voiceCallIconPackage,
      hideVoiceCall: configuration?.callButtonsConfiguration?.hideVoiceCall ?? group!=null,
      hideVideoCall: configuration?.callButtonsConfiguration?.hideVideoCall,
      ongoingCallConfiguration: configuration?.callButtonsConfiguration?.ongoingCallConfiguration ?? configuration?.ongoingCallConfiguration,
    ));

    //adding the initial header menu contents to the list of widgets to be displayed in the header menu.
    if (currentHeaderMenu != null) {
      menuItems.add(currentHeaderMenu);
    }

    //returning the list of widgets to be displayed in the header menu.
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: menuItems,
    );
  }

  //------------ sdk call events --------------------
  ///[onIncomingCallReceived] method is used to handle incoming call events.
  @override
  void onIncomingCallReceived(Call call) {
    User? user;
    // Group? group;
    if (call.callInitiator is User) {
      user = call.callInitiator as User;
    }
    if (CallNavigationContext.navigatorKey.currentContext != null) {
      Navigator.push(
          CallNavigationContext.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => CometChatIncomingCall(call: call, user: user,
            onError: configuration?.incomingCallConfiguration?.onError,
              disableSoundForCalls: configuration?.incomingCallConfiguration?.disableSoundForCalls,
              customSoundForCalls: configuration?.incomingCallConfiguration?.customSoundForCalls,
              customSoundForCallsPackage: configuration?.incomingCallConfiguration?.customSoundForCallsPackage,
              declineButtonText: configuration?.incomingCallConfiguration?.declineButtonText,
              declineButtonStyle: configuration?.incomingCallConfiguration?.declineButtonStyle,
              declineButtonIconUrl: configuration?.incomingCallConfiguration?.declineButtonIconUrl,
              declineButtonIconUrlPackage: configuration?.incomingCallConfiguration?.declineButtonIconUrlPackage,
              cardStyle: configuration?.incomingCallConfiguration?.cardStyle,
              subtitle: configuration?.incomingCallConfiguration?.subtitle,
              theme: configuration?.incomingCallConfiguration?.theme,
              acceptButtonIconUrl: configuration?.incomingCallConfiguration?.acceptButtonIconUrl,
              acceptButtonIconUrlPackage: configuration?.incomingCallConfiguration?.acceptButtonIconUrlPackage,
              acceptButtonStyle: configuration?.incomingCallConfiguration?.acceptButtonStyle,
              acceptButtonText: configuration?.incomingCallConfiguration?.acceptButtonText,
              onAccept: configuration?.incomingCallConfiguration?.onAccept,
              onDecline: configuration?.incomingCallConfiguration?.onDecline,
              incomingCallStyle: configuration?.incomingCallConfiguration?.incomingCallStyle,
              avatarStyle: configuration?.incomingCallConfiguration?.avatarStyle,
              ongoingCallConfiguration: configuration?.incomingCallConfiguration?.ongoingCallConfiguration ??  configuration?.ongoingCallConfiguration,
            ),
          ));
    }
  }


  @override
  void onOutgoingCallAccepted(Call call) {
    activeCall = call;
  }


  @override
  void onIncomingCallCancelled(Call call) {
    if (activeCall != null && activeCall?.id == call.id) {
      activeCall = null;
    }
  }


  //----------- UI Kit call events---------
  @override
  void ccOutgoingCall(Call call) {
    activeCall = call;
  }

  @override
  void ccCallRejected(Call call) {
    if (activeCall != null && activeCall?.id == call.id) {
      activeCall = null;
    }
  }

  @override
  void ccCallEnded(Call call) {
    if (activeCall != null && activeCall?.id == call.id) {
      activeCall = null;
    }
  }
}
