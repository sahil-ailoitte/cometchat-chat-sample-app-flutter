import '../../../cometchat_uikit_shared.dart';


/// Represents a message that includes a form with interactive elements.
class FormMessage extends InteractiveMessage {

  /// Creates a new [FormMessage] instance.
  ///
  /// The [formFields] represent the list of form fields within the message.
  ///
  /// The [submitElement] is the button element used for form submission.
  ///
  /// The [title] is the title of the form message.
  ///
  /// The rest of the parameters are optional and are inherited from [InteractiveMessage].
  FormMessage(
      {required this.formFields,
      required this.submitElement,
      required this.title,
      tags,
      int? id,
      String? muid,
      User? sender,
      AppEntity? receiver,
      required String receiverUid,
      String type = MessageTypeConstants.form,
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
      this.goalCompletionText,
      required InteractionGoal? interactionGoal,
      List<Interaction>? interactions,
      bool? allowSenderInteraction})
      : super(
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
            interactions: interactions,
            interactionGoal: interactionGoal,
            allowSenderInteraction: allowSenderInteraction ?? false,
            interactiveData: {
              // ModelColumns.formFields : formFields.map((e) => e.toMap()).toList(),
              // ModelColumns.submitElement : submitElement.toMap(),
              // ModelColumns.title : title,
            });

  /// The title of the form message.
  String title;


  /// The list of form fields in the message.
  List<ElementEntity> formFields;

  /// The button element used for form submission.
  ButtonElement submitElement;


  /// Text displayed upon completing the form's goal.
  String? goalCompletionText;



  /// Converts the [FormMessage] to an [InteractiveMessage].
  InteractiveMessage toInteractiveMessage() {
    List<Map<String, dynamic>> formFieldMap = [];
    for (var element in formFields) {
      formFieldMap.add(element.toMap());
    }
    interactiveData[ModelFieldConstants.formFields] = formFieldMap;

    interactiveData[ModelFieldConstants.submitElement] = submitElement.toMap();
    if (Utils.isValidString(title)) {
      interactiveData[ModelFieldConstants.title] = title;
    }
    if (Utils.isValidString(goalCompletionText)) {
      interactiveData[ModelFieldConstants.goalCompletionText] =
          goalCompletionText;
    }

    return this;
  }

  factory FormMessage.fromInteractiveMessage(InteractiveMessage message) {
    List<ElementEntity> elementList = [];
    ButtonElement? submitElement;
    if (message.interactiveData[ModelFieldConstants.formFields] != null) {
      for (var element in (message
          .interactiveData[ModelFieldConstants.formFields] as List)) {
        elementList.add(ElementEntity.fromMap(element));
      }
    }

    if (message.interactiveData[ModelFieldConstants.submitElement] != null) {
      submitElement = ButtonElement.fromMap(
          message.interactiveData[ModelFieldConstants.submitElement]);
    } else {
      submitElement = ButtonElement(
          elementType: UIElementTypeConstants.button,
          elementId: "xxx1234xxx",
          buttonText: "Not found");
    }

    return FormMessage(
        id: message.id,
        receiverType: message.receiverType,
        tags: message.tags,
        muid: message.muid,
        sender: message.sender,
        receiver: message.sender,
        receiverUid: message.receiverUid,
        type: message.type,
        category: message.category,
        sentAt: message.sentAt,
        deliveredAt: message.deliveredAt,
        readAt: message.readAt,
        metadata: message.metadata,
        readByMeAt: message.readByMeAt,
        deliveredToMeAt: message.deliveredToMeAt,
        deletedAt: message.deletedAt,
        editedAt: message.editedAt,
        deletedBy: message.deletedBy,
        editedBy: message.editedBy,
        updatedAt: message.updatedAt,
        conversationId: message.conversationId,
        parentMessageId: message.parentMessageId,
        replyCount: message.replyCount,
        title: message.interactiveData[ModelFieldConstants.title]??"",
        goalCompletionText:
            message.interactiveData[ModelFieldConstants.goalCompletionText],
        formFields: elementList,
        submitElement: submitElement,
        interactionGoal: message.interactionGoal,
        interactions: message.interactions,
        allowSenderInteraction: message.allowSenderInteraction);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map[ModelFieldConstants.title] = title;
    map[ModelFieldConstants.submitElement] = submitElement.toMap();
    map[ModelFieldConstants.formFields] =
        formFields.map((e) => e.toMap()).toList();
    if (goalCompletionText != null) {
      map[ModelFieldConstants.goalCompletionText] = goalCompletionText;
    }

    return map;
  }
}
