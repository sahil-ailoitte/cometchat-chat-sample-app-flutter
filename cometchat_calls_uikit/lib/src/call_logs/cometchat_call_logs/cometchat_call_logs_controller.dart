import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CometChatCallLogsController
    extends CometChatListController<CallLog, String> {
  CometChatCallLogsController(
      {required this.callLogsBuilderProtocol,
      OnError? onError,
      this.outgoingCallConfiguration,
      this.ongoingCallConfiguration})
      : super(callLogsBuilderProtocol.getRequest(), onError: onError);

  late CallLogsBuilderProtocol callLogsBuilderProtocol;

  User? loggedInUser;
  String? authToken;

  CallLog? lastElement;

  OutgoingCallConfiguration? outgoingCallConfiguration;

  OngoingCallConfiguration? ongoingCallConfiguration;

  Map<String, List<CallLog>> groupedEntries = {};

  @override
  void onInit() {
    super.onInit();
    _initializeLoggedInUser();
  }

  _initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
  }

  @override
  loadMoreElements({bool Function(CallLog element)? isIncluded}) async {
    isLoading = true;
    loggedInUser ??= await CometChat.getLoggedInUser();
    try {
      await request.fetchNext(onSuccess: (List<CallLog> fetchedList) {
        if (fetchedList.isEmpty) {
          isLoading = false;
          hasMoreItems = false;
        } else {
          isLoading = false;
          hasMoreItems = true;
          for (var element in fetchedList) {
            final date = element.initiatedAt;
            if (!groupedEntries
                .containsKey(CallLogsUtils.storeValueInMapTime(date!))) {
              groupedEntries[CallLogsUtils.storeValueInMapTime(date)] = [];
            }
            groupedEntries[CallLogsUtils.storeValueInMapTime(date)]!
                .add(element);
            if (isIncluded != null && isIncluded(element) == true) {
              list.add(element);
            } else {
              list.add(element);
            }
          }
        }
        update();
      }, onError: (CometChatCallsException e) {
        if (kDebugMode) {
          debugPrint("Error -> ${e.details}");
        }
        if (onError != null) {
          onError!(e);
        } else {
          error = e;
          hasError = true;
        }

        update();
      });
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint("Error in Catch  -> $e");
      }
      error = CometChatCallsException("ERR", s.toString(), "Error");
      hasError = true;
      isLoading = false;
      hasMoreItems = false;
      update();
    }
  }

  @override
  String getKey(CallLog element) {
    return element.mid!;
  }

  @override
  bool match(CallLog elementA, CallLog elementB) {
    return elementA.sessionId == elementB.sessionId;
  }

  // Initiate Call
  void initiateCallWorkflowUser(CallLog callLog, BuildContext context) {
    Call call = Call(
      receiverUid: CallLogsUtils.returnReceiverId(loggedInUser, callLog),
      receiverType: ReceiverTypeConstants.user,
      type: callLog.type ?? CallTypeConstants.audioCall,
    );

    CometChatUIKitCalls.initiateCall(call, onSuccess: (Call returnedCall) {
      returnedCall.category = MessageCategoryConstants.call;
      CometChatCallEvents.ccOutgoingCall(returnedCall);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CometChatOutgoingCall(
              call: returnedCall,
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
              ongoingCallConfiguration:
                  outgoingCallConfiguration?.ongoingCallConfiguration ??
                      ongoingCallConfiguration,
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
  void initiateCall(CallLog callLog, BuildContext context) {
    if (CallLogsUtils.isUser(callLog)) {
      initiateCallWorkflowUser(callLog, context);
    }
  }
}
