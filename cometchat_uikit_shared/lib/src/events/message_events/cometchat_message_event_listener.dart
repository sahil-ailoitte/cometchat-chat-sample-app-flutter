import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

enum LiveReactionType { liveReaction }

///Listener class for [CometChatMessages]
abstract class CometChatMessageEventListener implements UIEventHandler {
  //---composer events---
  //event for message sent by logged-in user
  void ccMessageSent(BaseMessage message, MessageStatus messageStatus) {}

  //---message list events---
  //event for message edited by logged-in user
  void ccMessageEdited(BaseMessage message, MessageEditStatus status) {}

  //event for message deleted by logged-in user
  void ccMessageDeleted(BaseMessage message, EventStatus messageStatus) {}

  //event for message read by logged-in user
  void ccMessageRead(BaseMessage message) {}

  //event for transient message sent by logged-in user
  void ccLiveReaction(String reaction) {}

  //event for forwarding message by logged-in user
  void ccMessageForwarded(BaseMessage message,List<User>? usersSent , List<Group>? groupsSent,MessageStatus status ){}

  //event for forwarding message by logged-in user
  void onTextMessageReceived(TextMessage textMessage) {}

  //event for forwarding message by logged-in user
  void onMediaMessageReceived(MediaMessage mediaMessage) {}

  //event for forwarding message by logged-in user
  void onCustomMessageReceived(CustomMessage customMessage) {}

  //event for on transient message received
  void onTypingStarted(TypingIndicator typingIndicator) {}

  //event for on transient message received
  void onTypingEnded(TypingIndicator typingIndicator) {}

  //event for on transient message received
  void onMessagesDelivered(MessageReceipt messageReceipt) {}

  //event for on transient message received
  void onMessagesRead(MessageReceipt messageReceipt) {}

  //event for on transient message received
  void onMessageEdited(BaseMessage message) {}

  //event for on transient message received
  void onMessageDeleted(BaseMessage message) {}

  //event for on transient message received
  void onTransientMessageReceived(TransientMessage message) {}

  //event for forwarding message by logged-in user
  void onFormMessageReceived(FormMessage formMessage) {}

  //event for forwarding message by logged-in user
  void onCardMessageReceived(CardMessage cardMessage) {}

  //event for forwarding message by logged-in user
  void onCustomInteractiveMessageReceived(CustomInteractiveMessage customInteractiveMessage) {}

  //event for completion of interaction goals
  void onInteractionGoalCompleted(InteractionReceipt receipt) {}

  //event for listening to meeting message events
  void onSchedulerMessageReceived(SchedulerMessage schedulerMessage) {}
}
