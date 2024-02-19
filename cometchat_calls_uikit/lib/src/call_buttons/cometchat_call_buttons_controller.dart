
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:get/get.dart';

/// [CometChatCallButtonsController] is the view model class for [CometChatCallButtons]
class CometChatCallButtonsController extends GetxController
    with CometChatCallEventListener, CallListener {
  ///[user] is a object of User which is used to initiate call.
  final User? user;

  ///[group] is a object of Group which is used to initiate call.
  final Group? group;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final OutgoingCallConfiguration? outgoingCallConfiguration;

  ///[_listenerId] is a unique identifier for the listener of call events.
  late String _listenerId;

  late String receiverType;
  late String receiverId;

  bool disabled = false;
  late BuildContext context;

  ///[onError] is a function which will called when some error occurs.
  final OnError? onError;

  ///[_loggedInUser] is a object of User which contains the details of logged-in user.
  late User? _loggedInUser;

  ///[ongoingCallConfiguration] is a object of [OngoingCallConfiguration] which sets the configuration for ongoing call
  final OngoingCallConfiguration? ongoingCallConfiguration;

  /// [CometChatCallButtonsController] constructor requires [user], [group] and [onError] while initializing.
  CometChatCallButtonsController({
    this.user,
    this.group,
    this.onError,
    this.outgoingCallConfiguration,
    this.ongoingCallConfiguration,
  }) {
    setUser(user);
    setGroup(group);
    initializeDependencies();
  }

  @override
  void onInit() {
    _listenerId =
        "callButtons${DateTime.now().microsecondsSinceEpoch.toString()}";
    addCallListener();
    super.onInit();
  }

  @override
  void onClose() {
    removeCallListener();
    super.onClose();
  }

  initializeDependencies() async {
    _loggedInUser = await CometChatUIKit.getLoggedInUser();
  }

  void setUser(User? user) {
    if (user != null) {
      receiverType = ReceiverTypeConstants.user;
      receiverId = user.uid;
    }
  }

  void setGroup(Group? group) {
    if (group != null) {
      receiverType = ReceiverTypeConstants.group;
      receiverId = group.guid;
    }
  }

  void addCallListener() {
    CometChat.addCallListener(_listenerId, this);
    CometChatCallEvents.addCallEventsListener(_listenerId, this);
  }

  void removeCallListener() {
    CometChat.removeCallListener(_listenerId);
    CometChatCallEvents.removeCallEventsListener(_listenerId);
  }

  @override
  void ccCallRejected(Call call) {
    disabled = false;
    update();
  }

  @override
  void ccCallEnded(Call call) {
    disabled = false;
    update();
  }

  @override
  void onOutgoingCallRejected(Call call) {
    disabled = false;
    update();
  }

  @override
  void onCallEndedMessageReceived(Call call) {
    disabled=false;
    update();
  }

  void initiateMeetWorkflow(String callType) {
    MainVideoContainerSetting videoSettings = MainVideoContainerSetting();
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
            callSettingsBuilder:
                ongoingCallConfiguration?.callSettingsBuilder ??
                    callSettingsBuilder,
            sessionId: receiverId,
            callWorkFlow: CallWorkFlow.directCalling,
            onError: ongoingCallConfiguration?.onError ?? onError,
          ),
        ));
    if (kDebugMode) {
      debugPrint('expecting to have navigated to CometChatOngoingCall screen');
    }
    Map<String, dynamic> customData = <String, dynamic>{};
    try {
      customData["callType"] = CallTypeConstants.videoCall;
      customData["sessionID"] = receiverId;
    } catch (e) {
      if (kDebugMode) {
        print('error in parsing customData');
      }
    }
    CustomMessage customMessage = CustomMessage(
        receiverUid: receiverId,
        receiverType: ReceiverTypeConstants.group,
        type: CallExtensionConstants.meeting,
        customData: customData);
    customMessage.receiver = group;
    customMessage.sentAt = DateTime.now();
    customMessage.muid = DateTime.now().microsecondsSinceEpoch.toString();
    customMessage.category = MessageCategoryConstants.custom;
    customMessage.sender = _loggedInUser;

    Map<String, dynamic>? metadata = {};
    try {
      metadata = customMessage.metadata;
      if (metadata == null) {
        metadata = {};
        metadata["incrementUnreadCount"] = true;
        metadata["pushNotification"] = CallExtensionConstants.meeting;
      } else {
        metadata["incrementUnreadCount"] = true;
        // metadata["pushNotification"] = MessageTypeConstants.meeting;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('error in parsing metadata');
      }
    }
    customMessage.metadata = metadata;
    CometChatUIKit.sendCustomMessage(customMessage,
        onSuccess: (CustomMessage directCallMessage) {
      CometChatMessageEvents.ccMessageSent(directCallMessage, MessageStatus.sent);
    }, onError: (CometChatException e) {
      if (customMessage.metadata != null) {
        customMessage.metadata!["error"] = e;
      } else {
        customMessage.metadata = {"error": e};
      }
      CometChatMessageEvents.ccMessageSent(customMessage, MessageStatus.error);
    });
  }

  void initiateCallWorkflow(String callType) {
    Call call = Call(
      receiverUid: receiverId,
      receiverType: ReceiverTypeConstants.user,
      type: callType,
    );

    CometChatUIKitCalls.initiateCall(call, onSuccess: (Call returnedCall) {
      returnedCall.category = MessageCategoryConstants.call;
      CometChatCallEvents.ccOutgoingCall(returnedCall);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CometChatOutgoingCall(
              call: returnedCall,
              user: user,
              theme: outgoingCallConfiguration?.theme,
              subtitle: outgoingCallConfiguration?.subtitle,
              buttonStyle: outgoingCallConfiguration?.buttonStyle,
              cardStyle: outgoingCallConfiguration?.cardStyle,
              declineButtonIconUrl:
                  outgoingCallConfiguration?.declineButtonIconUrl,
              declineButtonIconUrlPackage:
                  outgoingCallConfiguration?.declineButtonIconUrlPackage,
              declineButtonText: outgoingCallConfiguration?.declineButtonText,
              onDecline: outgoingCallConfiguration?.onDecline,
              disableSoundForCalls:
                  outgoingCallConfiguration?.disableSoundForCalls,
              customSoundForCalls:
                  outgoingCallConfiguration?.customSoundForCalls,
              customSoundForCallsPackage:
                  outgoingCallConfiguration?.customSoundForCallsPackage,
              onError: outgoingCallConfiguration?.onError,
              outgoingCallStyle: outgoingCallConfiguration?.outgoingCallStyle,
              avatarStyle: outgoingCallConfiguration?.avatarStyle,
              ongoingCallConfiguration: outgoingCallConfiguration?.ongoingCallConfiguration ?? ongoingCallConfiguration,
            ),
          ));
    }, onError: (CometChatException e) {
      try {
        if (onError != null) {
          onError!(e);
        }
      } catch (err) {
        debugPrint('Error in initiating call: ${e.message}');
      }
    });
  }

  /// [initiateCall] is a method which is used to initiate call.
  void initiateCall(String callType) {
    disabled = true;
    update();

    if (receiverType == ReceiverTypeConstants.group) {
      initiateMeetWorkflow(callType);
    } else {
      initiateCallWorkflow(callType);
    }
  }
}
