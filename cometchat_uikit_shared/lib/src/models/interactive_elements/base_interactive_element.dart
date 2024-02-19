import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

class BaseInteractiveElement extends ElementEntity {
  ActionEntity? action;
  bool disableAfterInteracted;

  BaseInteractiveElement(
      {required String elementId,
      required String elementType,
      this.action,
      this.disableAfterInteracted = false})
      : super(elementId: elementId, elementType: elementType);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    if (action != null) {
      map[ModelFieldConstants.action] = action?.toMap();
    }

    map[ModelFieldConstants.disableAfterInteracted] = disableAfterInteracted;
    return map;
  }

  factory BaseInteractiveElement.fromMap(dynamic map) {
    if (map[ModelFieldConstants.elementType] == UIElementTypeConstants.button) {
      return ButtonElement.fromMap(map);
    } else {
      ActionEntity? action;
      if (map[ModelFieldConstants.action] != null) {
        action = ActionEntity.fromMap(map[ModelFieldConstants.action]);
      }

      return BaseInteractiveElement(
        elementType: map[ModelFieldConstants.elementType],
        elementId: map[ModelFieldConstants.elementId],
        action: action,
        disableAfterInteracted: map[ModelFieldConstants.disableAfterInteracted],
      );
    }
  }
}
