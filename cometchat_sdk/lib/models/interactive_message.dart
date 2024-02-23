import '../models/app_entity.dart';
import '../models/base_message.dart';
import '../models/group.dart';
import '../models/user.dart';
import 'dart:convert';

import '../utils/constants.dart';
import '../models/interaction.dart';
import '../models/interaction_goal.dart';
import 'dart:io' as  ioPlatform;


/// Represents a message with interactive elements.
class InteractiveMessage extends BaseMessage {


  Map<String, dynamic> interactiveData;//Contains the data to create field
  List<Interaction>?  interactions; //List of interactions
  InteractionGoal? interactionGoal;//Gives a parameter to perform changes
  List<String>? tags;//Gives a list of tags
  bool allowSenderInteraction;


  InteractiveMessage({
    required this.interactiveData,
    this.interactions,
    this.interactionGoal,
    this.tags,
    int? id,
    String? muid,
    User? sender,
    AppEntity? receiver,
    required String receiverUid,
    required String type,
    required String receiverType,
    DateTime? sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    Map<String, dynamic>? metadata,
    DateTime? readByMeAt,
    DateTime? deliveredToMeAt,
    DateTime? deletedAt,
    DateTime? editedAt,
    String? deletedBy,
    String? editedBy,
    DateTime? updatedAt,
    String? conversationId,
    int? parentMessageId,
    int? replyCount,
    this.allowSenderInteraction = false,
    int? unreadRepliesCount,
  }) : super(
    id: id ?? 0,
    muid: muid ?? '',
    sender: sender,
    receiver: receiver,
    receiverUid: receiverUid,
    type: type,
    receiverType: receiverType,
    category: CometChatMessageCategory.interactive,
    sentAt: sentAt,
    deliveredAt: deliveredAt,
    readAt: readAt,
    metadata: metadata,
    readByMeAt: readByMeAt,
    deliveredToMeAt: deliveredToMeAt,
    deletedAt: deletedAt,
    editedAt: editedAt,
    deletedBy: deletedBy,
    editedBy: editedBy,
    updatedAt: updatedAt,
    conversationId: conversationId,
    parentMessageId: parentMessageId ?? 0,
    replyCount: replyCount ?? 0,
  );

  factory InteractiveMessage.fromMap(dynamic map, {AppEntity? receiver}) {

    bool? allowSenderInteraction = map["allowSenderInteraction"];
    Map<String, dynamic> _interactiveData;

    if(ioPlatform.Platform.isIOS){
      _interactiveData = map['interactiveData']?.cast<String, dynamic>() ?? {};
    }else{
      _interactiveData = Map<String, dynamic>.from(json.decode(map['interactiveData'] ?? '{}'));
    }
    if (map == null)
      throw ArgumentError('The type of custom message map is null');

    final appEntity = (map['receiver'] == null)
        ? receiver
        : (map['receiverType'] == 'user')
        ? User.fromMap(map['receiver'])
        : Group.fromMap(map['receiver']);

    final conversationId = map['conversationId'].isEmpty
        ? map['receiverType'] == 'user'
        ? '${map['sender']['uid']}_user_${(appEntity as User).uid}'
        : 'group_${map['receiver']['guid']}'
        : map['conversationId'];

    return InteractiveMessage(
      id: map['id'],
      muid: map['muid'],
      sender: map['sender'] == null ? null : User.fromMap(map['sender']),
      receiver: appEntity,
      receiverUid: map['receiverUid'],
      type: map['type'],
      receiverType: map['receiverType'],
      sentAt: map['sentAt'] == 0 || map['sentAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['sentAt'] * 1000),
      deliveredAt: map['deliveredAt'] == 0 || map['deliveredAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredAt'] * 1000),
      readAt: map['readAt'] == 0 || map['readAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readAt'] * 1000),
      metadata: Map<String, dynamic>.from(json.decode(map['metadata'] ?? '{}')),
      readByMeAt: map['readByMeAt'] == 0 || map['readByMeAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['readByMeAt'] * 1000),
      deliveredToMeAt: map['deliveredToMeAt'] == 0 ||
          map['deliveredToMeAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deliveredToMeAt'] * 1000),
      deletedAt: map['deletedAt'] == 0 || map['deletedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] * 1000),
      editedAt: map['editedAt'] == 0 || map['editedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['editedAt'] * 1000),
      deletedBy: map['deletedBy'],
      editedBy: map['editedBy'],
      updatedAt: map['updatedAt'] == 0 || map['updatedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] * 1000),
      conversationId: conversationId,
      parentMessageId: map['parentMessageId'],
      replyCount: map['replyCount'],
      tags: List<String>.from(map['tags'] ?? []),

      interactiveData: _interactiveData,
      interactionGoal: InteractionGoal.fromMap(map['interactionGoal']),
    interactions:map['interactions'] != null?(map['interactions']).map<Interaction>((optionMap) => Interaction.fromMap(optionMap))
        .toList():null,
      allowSenderInteraction: allowSenderInteraction??false,
      unreadRepliesCount: map['unreadRepliesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    User? userObj = sender;

    late Map receiverMap;
    if (receiverType == CometChatReceiverType.group) {
      Group grp = receiver as Group;
      receiverMap = grp.toJson();
    } else {
      User usr = receiver as User;
      receiverMap = usr.toJson();
    }

    final map = <String, dynamic>{};
    map['metadata'] = metadata;
    if (receiver != null) {
      map['receiver'] = receiverMap;
    }
    map['editedBy'] = editedBy;
    map['conversationId'] = conversationId;
    map['sentAt'] = sentAt == null ? 0 : sentAt?.millisecondsSinceEpoch;
    map['receiverUid'] = receiverUid;
    map['type'] = type;
    map['readAt'] = readAt == null ? 0 : readAt?.millisecondsSinceEpoch;
    map['deletedBy'] = deletedBy;
    map['deliveredAt'] =
    deliveredAt == null ? 0 : deliveredAt?.millisecondsSinceEpoch;
    map['muid'] = muid;

    map['deletedAt'] =
    deletedAt == null ? 0 : deletedAt?.millisecondsSinceEpoch;
    map['replyCount'] = replyCount;
    if (sender != null) {
      map['sender'] = userObj!.toJson();
    }
    map['receiverType'] = receiverType;
    map['editedAt'] = editedAt == null ? 0 : editedAt?.millisecondsSinceEpoch;
    map['parentMessageId'] = parentMessageId;
    map['readByMeAt'] =
    readByMeAt == null ? 0 : readByMeAt?.millisecondsSinceEpoch;
    map['id'] = id;
    map['category'] = category;
    map['deliveredToMeAt'] =
    deliveredToMeAt == null ? 0 : deliveredToMeAt?.millisecondsSinceEpoch;
    map['updatedAt'] =
    updatedAt == null ? 0 : updatedAt?.millisecondsSinceEpoch;
    map['interactiveData'] = interactiveData;
    map['interactions'] = interactions?.map((e) => e.toJson()).toList();
    map['interactionGoal'] = interactionGoal?.toMap();
    map['tags'] = tags;
    map['allowSenderInteraction'] = allowSenderInteraction;
    map['unreadRepliesCount'] = unreadRepliesCount;

    return map;
  }


}
