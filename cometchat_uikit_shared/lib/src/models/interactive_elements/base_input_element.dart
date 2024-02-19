import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

abstract class BaseInputElement<T> extends ElementEntity {
  T? response;
  T? defaultValue;
  bool optional;

  BaseInputElement({
    required String elementId,
    required String elementType,
    this.response,
    this.defaultValue,
    this.optional = true,
  }) : super(elementId: elementId, elementType: elementType);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[ModelFieldConstants.elementType] = elementType;
    map[ModelFieldConstants.elementId] = elementId;
    if (T is String && Utils.isValidString(defaultValue as String)) {
      map[ModelFieldConstants.defaultValue] = defaultValue;
    } else if (defaultValue != null) {
      map[ModelFieldConstants.defaultValue] = defaultValue;
    }
    map[ModelFieldConstants.optional] = optional;
    return map;
  }

  bool validateResponse();
}
