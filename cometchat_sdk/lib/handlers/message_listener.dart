import 'package:cometchat_sdk/cometchat_sdk.dart';


class MessageListener implements EventHandler {
  void onTextMessageReceived(TextMessage textMessage) {}
  void onMediaMessageReceived(MediaMessage mediaMessage) {}
  void onCustomMessageReceived(CustomMessage customMessage) {}
  void onTypingStarted(TypingIndicator typingIndicator) {}
  void onTypingEnded(TypingIndicator typingIndicator) {}
  void onMessagesDelivered(MessageReceipt messageReceipt) {}
  void onMessagesRead(MessageReceipt messageReceipt) {}
  void onMessageEdited(BaseMessage message) {}
  void onMessageDeleted(BaseMessage message) {}
  void onTransientMessageReceived(TransientMessage message) {}
  void onInteractiveMessageReceived(InteractiveMessage message) {}
  void onInteractionGoalCompleted(InteractionReceipt receipt) {}
///[onMessageReactionAdded] event is emitted when a reaction is added to a message.
  void onMessageReactionAdded(MessageReaction messageReaction) {}
///[onMessageReactionRemoved] event is emitted when a reaction is removed from a message.
  void onMessageReactionRemoved(MessageReaction messageReaction) {}
}

abstract class EventHandler {}
