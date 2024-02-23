import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CometChatHelper {

  /// Retrieves the [Conversation] object associated with the given [message].
  ///
  /// The [message] parameter represents the [BaseMessage] for which the corresponding [Conversation] is required.
  ///
  /// Returns a [Future] that resolves to the [Conversation] associated with the [message].
  /// Returns `null` if an error occurs during the retrieval process or if the logged-in user is null.
  static Future<Conversation?> getConversationFromMessage(BaseMessage message) async {
    try {
      String conversationType = message.receiverType;
      User? loggedInUser = await CometChat.getLoggedInUser();
      String? conversationId = message.conversationId;
      if (loggedInUser != null) {
        AppEntity appEntity = AppEntity();
        if (conversationType == CometChatReceiverType.user) {
          if (loggedInUser.uid == message.sender!.uid) {
            appEntity = message.receiver!;
          } else {
            appEntity = message.sender!;
          }
        } else {
          appEntity = message.receiver!;
        }
        Conversation conversation = Conversation(
            conversationId: conversationId,
            conversationType: conversationType,
            conversationWith: appEntity,
            lastMessage: message,
            updatedAt: message.updatedAt
        );
        return conversation;
      }else{
        return null;
      }
    } on PlatformException catch (platformException) {
      debugPrint("Error: $platformException");
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  /// Updates the [baseMessage] with the reaction information provided in [messageReaction].
  ///
  /// The [action] parameter specifies the type of reaction action, which can be either [ReactionAction.reactionAdded] or [ReactionAction.reactionRemoved].
  /// Returns a [Future] that resolves to the updated [baseMessage].
  /// Returns `null` if an error occurs during the process.
  static Future<BaseMessage?> updateMessageWithReactionInfo(BaseMessage baseMessage, MessageReaction messageReaction, String action) async {
    try {
      if (action == ReactionAction.reactionAdded) {
        if (baseMessage.id == messageReaction.messageId) {
          if (baseMessage.getReactions().length > 0) {
            int foundReactionIndex = -1;
            for (int j = 0; j < baseMessage.getReactions().length; j++) {
              ReactionCount reactionCount = baseMessage.getReactions()[j];
              if (reactionCount.reaction == messageReaction.reaction) {
                foundReactionIndex = j;
                break;
              }
            }
            if (foundReactionIndex != -1) {
              ReactionCount tempReactionCount = baseMessage.getReactions()[foundReactionIndex];
              baseMessage.getReactions()[foundReactionIndex].count = tempReactionCount.count! + 1;
            } else {
              ReactionCount tempReactionCount = ReactionCount();
              tempReactionCount.count = 1;
              tempReactionCount.reaction = messageReaction.reaction;
              baseMessage.getReactions().add(tempReactionCount);
            }
          } else {
            ReactionCount reactionCount = ReactionCount();
            reactionCount.count = 1;
            reactionCount.reaction = messageReaction.reaction;
            baseMessage.getReactions().add(reactionCount);
          }
          return baseMessage;
        }
      } else if (action == ReactionAction.reactionRemoved) {
        if (baseMessage.id == messageReaction.messageId) {
          if (baseMessage.getReactions().length > 0) {
            int foundReactionIndex = -1;
            for (int j = 0; j < baseMessage.getReactions().length; j++) {
              ReactionCount reactionCount = baseMessage.getReactions()[j];
              if (reactionCount.reaction == messageReaction.reaction) {
                foundReactionIndex = j;
                break;
              }
            }
            if (foundReactionIndex != -1) {
              ReactionCount tempReactionCount = baseMessage.getReactions()[foundReactionIndex];
              if (tempReactionCount.count! > 1) {
                baseMessage.getReactions()[foundReactionIndex].count = tempReactionCount.count! - 1;
                final loggedInUserObj = await CometChat.getLoggedInUser();
                if (loggedInUserObj?.uid == messageReaction.uid) {
                  baseMessage.getReactions()[foundReactionIndex].reactedByMe = false;
                }
              } else {
                baseMessage.getReactions().removeAt(foundReactionIndex);
              }
            }
          }
          return baseMessage;
        }
      }
    } on PlatformException catch (platformException) {
      debugPrint("Error: $platformException");
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

}