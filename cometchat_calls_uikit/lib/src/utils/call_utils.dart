import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CallUtils] is a utility class that contains methods to perform call related operations.
class CallUtils {
  /// Returns the call status message.
  static String getCallStatus(
      BuildContext context, BaseMessage baseMessage, User? loggedInUser) {
    String callMessageText = "";
    //check if the message is a call message and the receiver type is user
    if (baseMessage is Call &&
        baseMessage.receiverType == ReceiverTypeConstants.user) {
      Call call = baseMessage;
      User initiator = call.callInitiator as User;
      //check if the call is initiated
      if (call.callStatus == CallStatusConstants.initiated) {
        //check if the logged in user is the initiator
        if (!isLoggedInUser(initiator, loggedInUser)) {
          callMessageText = Translations.of(context).incoming_call;
        } else {
          callMessageText = Translations.of(context).outgoing_call;
        }
      } else if (call.callStatus == CallStatusConstants.ongoing) {
        callMessageText = Translations.of(context).call_accepted;
      } else if (call.callStatus == CallStatusConstants.ended) {
        callMessageText = Translations.of(context).call_ended;
      } else if (call.callStatus == CallStatusConstants.unanswered) {
        if (isLoggedInUser(initiator, loggedInUser)) {
          callMessageText = Translations.of(context).call_unanswered;
        } else {
          callMessageText = Translations.of(context).missed_call;
        }
      } else if (call.callStatus == CallStatusConstants.cancelled) {
        if (isLoggedInUser(initiator, loggedInUser)) {
          callMessageText = Translations.of(context).call_cancelled;
        } else {
          callMessageText = Translations.of(context).missed_call;
        }
      } else if (call.callStatus == CallStatusConstants.rejected) {
        if (isLoggedInUser(initiator, loggedInUser)) {
          callMessageText = Translations.of(context).call_rejected;
        } else {
          callMessageText = Translations.of(context).missed_call;
        }
      } else if (call.callStatus == CallStatusConstants.busy) {
        if (isLoggedInUser(initiator, loggedInUser)) {
          callMessageText = Translations.of(context).call_rejected;
        } else {
          callMessageText = Translations.of(context).missed_call;
        }
      }
    }
    return " $callMessageText";
  }

  /// Returns true if the call is a video call.
  static bool isVideoCall(Call call) {
    return call.type == CallTypeConstants.videoCall;
  }

  /// Returns true if the call is initiated by the logged in user.
  static bool isLoggedInUser(User? initiator, User? loggedInUser) {
    if (initiator == null || loggedInUser == null) {
      return false;
    } else {
      return initiator.uid == loggedInUser.uid;
    }
  }

  static String getLastMessageForGroupCall(
      BaseMessage lastMessage, BuildContext context, User? loggedInUser) {
    String message = "";
    if (lastMessage.receiverType == ReceiverTypeConstants.group) {
      if (!isLoggedInUser(lastMessage.sender, loggedInUser)) {
        message =
            "${lastMessage.sender?.name} ${Translations.of(context).initiated_group_call}";
      } else {
        message = Translations.of(context).you_initiated_group_call;
      }
    }
    return message;
  }

  ///[isMissedCall] returns true if the call is missed call.
  static bool isMissedCall(Call call, User? loggedInUser) {
    if (call.receiverType == ReceiverTypeConstants.user) {
      User initiator = (call.callInitiator as User);
      if (call.callStatus == CallStatusConstants.unanswered) {
        return !isLoggedInUser(initiator, loggedInUser);
      } else if (call.callStatus == CallStatusConstants.cancelled) {
        return !isLoggedInUser(initiator, loggedInUser);
      } else if (call.callStatus == CallStatusConstants.rejected) {
        return !isLoggedInUser(initiator, loggedInUser);
      } else if (call.callStatus == CallStatusConstants.busy) {
        return !isLoggedInUser(initiator, loggedInUser);
      }
    }

    return false;
  }

  /// Returns true if the call is initiated by the logged in user.
  static bool callLogLoggedInUser(CallLog? callLog, User? loggedInUser) {
    if (callLog == null || loggedInUser == null) {
      return false;
    } else if (callLog.initiator is CallEntity ||
        (callLog.receiver is CallEntity)) {
      if (callLog.initiator is CallUser) {
        CallUser initiatorUser = callLog.initiator as CallUser;
        return initiatorUser.uid == loggedInUser.uid;
      } else if (callLog.receiver is CallUser) {
        CallUser receiverUser = callLog.receiver as CallUser;
        return receiverUser.uid == loggedInUser.uid;
      } else if (callLog.initiator is CallGroup) {
        CallUser receiverUser = callLog.receiver as CallUser;
        return receiverUser.uid == loggedInUser.uid;
      } else if (callLog.receiver is CallGroup) {
        CallUser initiatorUser = callLog.initiator as CallUser;
        return initiatorUser.uid == loggedInUser.uid;
      }
    }
    return false;
  }

  /// [getStatus] return call status
  static String getStatus(
      BuildContext? context, CallLog? callLog, User? loggedInUser) {
    String callMessageText = "";

    if (callLog == null || loggedInUser == null) {
      return "";
    }

    if (context == null) {
      return "";
    }

    //check if the call is initiated
    if (callLog.status == CallStatusConstants.initiated) {
      //check if the logged in user is the initiator
      if (!callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).incoming_call;
      } else {
        callMessageText = Translations.of(context).outgoing_call;
      }
    } else if (callLog.status == CallStatusConstants.ongoing) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).ongoing_call;
      } else {
        callMessageText = Translations.of(context).ongoing_call;
      }
    } else if (callLog.status == CallStatusConstants.ended) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).outgoing_call;
      } else {
        callMessageText = Translations.of(context).incoming_call;
      }
    } else if (callLog.status == CallStatusConstants.unanswered) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).unanswered_call;
      } else {
        callMessageText = Translations.of(context).missed_call;
      }
    } else if (callLog.status == CallStatusConstants.cancelled) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).cancelled_call;
      } else {
        callMessageText = Translations.of(context).missed_call;
      }
    } else if (callLog.status == CallStatusConstants.rejected) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).rejected_call;
      } else {
        callMessageText = Translations.of(context).missed_call;
      }
    } else if (callLog.status == CallStatusConstants.busy) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callMessageText = Translations.of(context).unanswered_call;
      } else {
        callMessageText = Translations.of(context).missed_call;
      }
    }
    return " $callMessageText";
  }

  /// [getCallIcon] Return call status icon
  static String getCallIcon(
    BuildContext context,
    CallLog callLog,
    User? loggedInUser, {
    String? incomingAudioCallIcon,
    String? incomingVideoCallIcon,
    String? outgoingAudioCallIcon,
    String? outgoingVideoCallIcon,
    String? missedAudioCallIcon,
    String? missedVideoCallIcon,
  }) {
    String callStatusIcon = "";

    String incomingAudio =
        incomingAudioCallIcon ?? AssetConstants.audioIncoming;
    String incomingVideo =
        incomingVideoCallIcon ?? AssetConstants.videoIncoming;
    String outgoingAudio =
        outgoingAudioCallIcon ?? AssetConstants.audioOutgoing;
    String outgoingVideo =
        outgoingVideoCallIcon ?? AssetConstants.videoOutgoing;
    String missedAudio = missedAudioCallIcon ?? AssetConstants.audioMissed;
    String missedVideo = missedVideoCallIcon ?? AssetConstants.videoMissed;

    //check if the call is initiated
    if (callLog.status == CallStatusConstants.initiated) {
      //check if the logged in user is the initiator
      if (!callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? incomingAudio : incomingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      }
    } else if (callLog.status == CallStatusConstants.ongoing) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? incomingAudio : incomingVideo;
      }
    } else if (callLog.status == CallStatusConstants.ended) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? incomingAudio : incomingVideo;
      }
    } else if (callLog.status == CallStatusConstants.unanswered) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? missedAudio : missedVideo;
      }
    } else if (callLog.status == CallStatusConstants.cancelled) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? missedAudio : missedVideo;
      }
    } else if (callLog.status == CallStatusConstants.rejected) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? missedAudio : missedVideo;
      }
    } else if (callLog.status == CallStatusConstants.busy) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusIcon = (isAudioCall(callLog)) ? outgoingAudio : outgoingVideo;
      } else {
        callStatusIcon = (isAudioCall(callLog)) ? missedAudio : missedVideo;
      }
    }

    return callStatusIcon;
  }

  /// [getCallStatusColor] return call status color
  static Color getCallStatusColor(
    CallLog callLog,
    User? loggedInUser,
    CometChatTheme theme,
  ) {
    Color callStatusColor = theme.palette.getAccent700();
    //check if the call is initiated
    if (callLog.status == CallStatusConstants.initiated) {
      //check if the logged in user is the initiator
      if (!callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusColor = theme.palette.getAccent700(); // incoming Call
      } else {
        callStatusColor = theme.palette.getAccent700(); // outgoing Call
      }
    } else if (callLog.status == CallStatusConstants.ongoing) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusColor = theme.palette.getAccent700(); // ongoing Call
      } else {
        callStatusColor = theme.palette.getAccent700(); // ongoing Call
      }
    } else if (callLog.status == CallStatusConstants.ended) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusColor = theme.palette.getAccent700(); // outgoing Call
      } else {
        callStatusColor = theme.palette.getAccent700(); // incoming Call
      }
    } else if (callLog.status == CallStatusConstants.unanswered) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusColor = theme.palette.getAccent700(); // unAnswered Call
      } else {
        callStatusColor = theme.palette.getError(); // missed Call
      }
    } else if (callLog.status == CallStatusConstants.cancelled) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusColor = theme.palette.getAccent700(); // cancelled Call
      } else {
        callStatusColor = theme.palette.getError(); // missed Call
      }
    } else if (callLog.status == CallStatusConstants.rejected) {
      if (callLogLoggedInUser(callLog, loggedInUser)) {
        callStatusColor = theme.palette.getAccent700(); // rejected Call
      } else {
        callStatusColor = theme.palette.getError(); // missed Call
      }
    } else if (callLog.status == CallStatusConstants.busy) {
      callStatusColor = theme.palette.getAccent700(); // unAnswered Call
    } else {
      callStatusColor = theme.palette.getError(); // missed Call
    }

    return callStatusColor;
  }

  static bool isAudioCall(CallLog callLog) {
    return callLog.type == CallTypeConstants.audioCall;
  }
}
