import '../../../cometchat_uikit_shared.dart';

class ChatSDKEventInitializer with MessageListener{

  //Do not use this id, its reserved for cometchat own structure
  final String _listenerId = "__CometChatConstantListenerID__";

  ChatSDKEventInitializer(){
    CometChat.addMessageListener(_listenerId, this);
  }


  @override
  void onTextMessageReceived(TextMessage textMessage) {
    CometChatMessageEvents.onTextMessageReceived(textMessage);
  }

  @override
  void onMediaMessageReceived(MediaMessage mediaMessage) {
    CometChatMessageEvents.onMediaMessageReceived(mediaMessage);
  }

  @override
  void onCustomMessageReceived(CustomMessage customMessage) {
    CometChatMessageEvents.onCustomMessageReceived(customMessage);
  }

  @override
  void onTypingStarted(TypingIndicator typingIndicator) {
    CometChatMessageEvents.onTypingStarted(typingIndicator);
  }

  @override
  void onTypingEnded(TypingIndicator typingIndicator) {
    CometChatMessageEvents.onTypingEnded(typingIndicator);
  }

  @override
  void onMessagesDelivered(MessageReceipt messageReceipt) {
    CometChatMessageEvents.onMessagesDelivered(messageReceipt);
  }

  @override
  void onMessagesRead(MessageReceipt messageReceipt) {
    CometChatMessageEvents.onMessagesRead(messageReceipt);
  }

  @override
  void onMessageEdited(BaseMessage message) {

    InteractiveMessage? interactiveMessage;

    if(message.category==  MessageCategoryConstants.interactive){

      interactiveMessage =  InteractiveMessageUtils.getSpecificMessageFromInteractiveMessage(message as InteractiveMessage);
    }

    CometChatMessageEvents.onMessageEdited(interactiveMessage??message);
  }

  @override
  void onMessageDeleted(BaseMessage message) {
    InteractiveMessage? interactiveMessage;

    if(message.category==  MessageCategoryConstants.interactive){

      interactiveMessage =  InteractiveMessageUtils.getSpecificMessageFromInteractiveMessage(message as InteractiveMessage);
    }

    CometChatMessageEvents.onMessageDeleted(interactiveMessage??message);
  }

  @override
  void onTransientMessageReceived(TransientMessage message) {
    CometChatMessageEvents.onTransientMessageReceived(message);
  }

  @override
  void onInteractiveMessageReceived(InteractiveMessage message){

    if(message.type==MessageTypeConstants.form){
      CometChatMessageEvents.onFormMessageReceived(FormMessage.fromInteractiveMessage(message));
    }else if(message.type==MessageTypeConstants.card){
      CometChatMessageEvents.onCardMessageReceived( CardMessage.fromInteractiveMessage(message));
    }else if(message.type==MessageTypeConstants.scheduler){
      CometChatMessageEvents.onSchedulerMessageReceived( SchedulerMessage.fromInteractiveMessage(message));
    }else{
      CometChatMessageEvents.onCustomInteractiveMessageReceived( CustomInteractiveMessage.fromInteractiveMessage(message));
    }

  }

  @override
  void onInteractionGoalCompleted(InteractionReceipt receipt) {
    CometChatMessageEvents.onInteractionGoalCompleted(receipt);
  }




}