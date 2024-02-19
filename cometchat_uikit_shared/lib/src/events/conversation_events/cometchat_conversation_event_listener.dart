import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///Listener class for [CometChatConversations]
abstract class CometChatConversationEventListener implements UIEventHandler {
  ///[ccConversationDeleted] is used to inform the listeners
  ///when the logged-in user deletes a conversation
  void ccConversationDeleted(Conversation conversation) {}
}
