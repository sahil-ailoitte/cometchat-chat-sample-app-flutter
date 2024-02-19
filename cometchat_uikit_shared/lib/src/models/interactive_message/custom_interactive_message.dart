
import '../../../cometchat_uikit_shared.dart';

/// Represents a message that includes various types of messages for interactive elements.
class CustomInteractiveMessage extends InteractiveMessage {


  /// Creates a new [CustomInteractiveMessage] instance.
  /// The rest of the parameters are optional and are inherited from [InteractiveMessage].
  CustomInteractiveMessage({
    required this.customData,
    required this.subType,
    tags,
    int? id,
    String? muid,
    User? sender,
    AppEntity? receiver,
    required String receiverUid,
    String type = MessageTypeConstants.customInteractive,
    required String receiverType,
    String? category = MessageCategoryConstants.interactive,
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
  }) : super(
      id: id ?? 0,
      muid: muid ?? '',
      sender: sender,
      receiver: receiver,
      receiverUid: receiverUid,
      type: type,
      receiverType: receiverType,
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
      interactiveData: {
        ModelFieldConstants.customData : customData,

      }
  );

  Map<String, dynamic> customData;
  String subType;




  InteractiveMessage toInteractiveMessage() {
    interactiveData[ModelFieldConstants.customData] = customData;
    return this;
  }


  factory CustomInteractiveMessage.fromInteractiveMessage(InteractiveMessage message){

    List<ElementEntity> elementList = [];
    if(message.interactiveData[ModelFieldConstants.formFields]!=null){
      for (var element in (message.interactiveData[ModelFieldConstants.formFields] as List) ) {
        elementList.add(ElementEntity.fromMap(element));
      }
    }


    return CustomInteractiveMessage(
        id: message.id,
        receiverType: message.receiverType,
        tags : message.tags,
        muid: message.muid,
        sender :  message.sender,
        receiver:  message.sender,
        receiverUid:  message.receiverUid,
        type:  message.type,
        category :  message.category,
        sentAt:  message.sentAt,
        deliveredAt:  message.deliveredAt,
        readAt:  message.readAt,
        metadata:  message.metadata,
        readByMeAt:  message.readByMeAt,
        deliveredToMeAt:  message.deliveredToMeAt,
        deletedAt:  message.deletedAt,
        editedAt:  message.editedAt,
        deletedBy:  message.deletedBy,
        editedBy:  message.editedBy,
        updatedAt:  message.updatedAt,
        conversationId:  message.conversationId,
        parentMessageId:  message.parentMessageId,
        replyCount:  message.replyCount,
        customData: message.interactiveData[ModelFieldConstants.customData],
      subType: message.interactiveData[ModelFieldConstants.subType],
    );

  }


  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map[ModelFieldConstants.customData] = customData;

    return map;

  }

}