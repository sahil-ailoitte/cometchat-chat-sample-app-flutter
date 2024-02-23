import 'package:flutter/services.dart';

MethodChannel channel = const MethodChannel('cometchat');
EventChannel eventStreamChannel =
    const EventChannel('cometchat_message_stream');
EventChannel typingStream = const EventChannel('cometchat_typing_stream');

class CometChatReceiverType {
  static const String user = 'user';
  static const String group = 'group';
}

class CometChatMessageType {
  static const String image = 'image';
  static const String video = 'video';
  static const String audio = 'audio';
  static const String file = 'file';
  static const String text = 'text';
  static const String custom = 'custom';
}

class CometChatGroupType {
  static const String private = 'private';
  static const String public = 'public';
  static const String password = 'password';
}

class CometChatConversationType {
  static const String user = 'user';
  static const String group = 'group';
}

class CometChatUserStatus {
  static const String online = 'online';
  static const String offline = 'offline';
}

class CometChatMessageCategory {
  static const String message = 'message';
  static const String action = 'action';
  static const String call = 'call';
  static const String custom = 'custom';
  static const String interactive = 'interactive';
}

class CometChatMemberScope {
  static const String admin = 'admin';
  static const String moderator = 'moderator';
  static const String participant = 'participant';
}

class CometChatCallType {
  static const String audio = 'audio';
  static const String video = 'video';
}

class CometChatCallStatus {
  static const String initiated = 'initiated';
  static const String ongoing = 'ongoing';
  static const String unanswered = 'unanswered';
  static const String rejected = 'rejected';
  static const String busy = 'busy';
  static const String cancelled = 'cancelled';
  static const String ended = 'ended';
}

class CometChatWSState {
  static const String connected = 'connected';
  static const String connecting = 'connecting';
  static const String disconnected = 'disconnected';
  static const String featureThrottled = 'featureThrottled';
}

class CometChatSubscriptionType {
  static const String none = 'none';
  static const String allUsers = 'allUsers';
  static const String roles = 'roles';
  static const String friends = 'friends';
}

class CometChatBlockedUsersDirection {
  static const String directionBlockedByMe = "blockedByMe";
  static const String directionHasBlockedMe = "hasBlockedMe";
  static const String directionBoth = "both";
}

class CometChatReceiptType {
  static const String delivered = "delivered";
  static const String read = "read";
}

class ConversationType {
  static const user = "user";
  static const group = "group";
}

class ErrorCode {
  static const errorUnhandledException = "ERROR_UNHANDLED_EXCEPTION";
  static const errorUserNotLoggedIn = "ERROR_USER_NOT_LOGGED_IN";
  static const errorInvalidReceiverId = "ERROR_INVALID_RECEIVER_ID";
  static const errorInvalidReceiverType = "ERROR_INVALID_RECEIVER_TYPE";
  static const errorEmptyAskBotQuestion = "ERROR_EMPTY_QUESTION";
  static const errorEmptyBotID = "ERROR_EMPTY_BOT_ID";
  static const errorEmptyFeature = "ERROR_EMPTY_FEATURE";
}

class ErrorMessage {
  static const errorMessageUserNotLoggedIn =
      "Please log in to CometChat before calling this method";
  static const errorMessageInvalidReceiverId =
      "Invalid Receiver ID. The receiver ID cannot be null or empty";
  static const errorEmptyFeature =
      "Feature ID cannot be null or empty, Please provide a valid Feature ID";
  static const errorMessageInvalidReceiverType =
      "Invalid Receiver Type. Please provide a valid Receiver type";
  static const errorEmptyAskBotQuestion = "Question cannot be null or empty";
  static const errorEmptyBotID =
      "BotID cannot be null or empty, Please provide a valid Bot ID";
}

class MessageConstants {
  static const String mentionedUsers = "mentionedUsers";
  static const String reactions = "reactions";
  static const String hasMentionedMe = "hasMentionedMe";
}

class InteractionGoalType {
  static const anyAction = "anyAction";
  static const anyOf = "anyOf";
  static const allOf = "allOf";
  static const none = "none";
}

class ReactionAction {
  static const String reactionAdded = 'added';
  static const String reactionRemoved = 'removed';
}

