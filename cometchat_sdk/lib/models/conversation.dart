import 'app_entity.dart';
import 'base_message.dart';
import 'group.dart';
import 'user.dart';

class Conversation {
  ///[conversationId] is the unique ID of the conversation.
  String? conversationId;

  ///[conversationType] is the type of conversation.
  String conversationType;

  ///[conversationWith] is the user or group with whom the conversation is taking place.
  AppEntity conversationWith;

  ///[lastMessage] is the last message sent in the conversation.
  BaseMessage? lastMessage;

  ///[updatedAt] is the time at which the conversation was last updated.
  DateTime? updatedAt;

  ///[unreadMessageCount] is the count of unread messages in the conversation.
  int? unreadMessageCount;

  ///[tags] is a list of tags associated with the conversation.
  List<String>? tags;

  ///[unreadMentionsCount] is the count of unread mentions in the conversation.
  int unreadMentionsCount;

  ///[lastReadMessageId] is the ID of the last read message in the conversation.
  String? lastReadMessageId;

  Conversation({
    this.conversationId,
    required this.conversationType,
    required this.conversationWith,
    this.lastMessage,
    this.updatedAt,
    this.unreadMessageCount = 0,
    this.tags,
    this.unreadMentionsCount = 0,
    this.lastReadMessageId,
  });

  factory Conversation.fromMap(dynamic map) {
    if (map == null)
      throw ArgumentError('The type of conversation map is null');

    final appEntity = (map['conversationType'] == 'user')
        ? User.fromMap(map['conversationWith'])
        : Group.fromMap(map['conversationWith']);

    return Conversation(
      conversationId: map['conversationId'],
      conversationType: map['conversationType'],
      conversationWith: appEntity,
      lastMessage: map['lastMessage'] == null || map['lastMessage'].isEmpty
          ? null
          : BaseMessage.fromMap(map['lastMessage']),
      updatedAt:map['updatedAt']==0|| map['updatedAt']==null?null:
      DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] * 1000),
      unreadMessageCount: map['unreadMessageCount'],
      tags: List<String>.from(map['tags'] ?? [],),
      unreadMentionsCount: map['unreadMentionsCount'],
      lastReadMessageId: map['lastReadMessageId'],
    );
  }

  @override
  String toString() {
    return 'Conversation{conversationId: $conversationId, conversationType: $conversationType, conversationWith: $conversationWith, lastMessage: $lastMessage, updatedAt: $updatedAt, unreadMessageCount: $unreadMessageCount, tags: $tags, unreadMentionsCount: $unreadMentionsCount, lastReadMessageId: $lastReadMessageId}';
  }
}
