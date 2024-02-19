import '../../../../cometchat_uikit_shared.dart';

/// Represents a text input model class , used to draw text input element .
class TextInputElement extends BaseInputElement<String> {
  TextInputElement({
    String elementType = UIElementTypeConstants.textInput,
    required String elementId,
    required this.label,
    this.maxLines = 1,
    this.placeholder,
    String? response,
    String? defaultValue,
    bool? optional = true,
  }) : super(
            elementType: elementType,
            elementId: elementId,
            response: response,
            defaultValue: defaultValue,
            optional: optional ?? true);

  String label;
  int maxLines;
  TextInputPlaceholder? placeholder;

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map[ModelFieldConstants.label] = label;
    map[ModelFieldConstants.maxLines] = maxLines;
    if (placeholder != null) {
      map[ModelFieldConstants.placeholder] = placeholder?.toMap();
    }
    return map;
  }

  factory TextInputElement.fromMap(dynamic map) {
    return TextInputElement(
      elementType: map[ModelFieldConstants.elementType],
      elementId: map[ModelFieldConstants.elementId],
      optional: map[ModelFieldConstants.optional] ?? true,
      label: map[ModelFieldConstants.label] ?? "Default text",
      maxLines: map[ModelFieldConstants.maxLines] ?? 1,
      defaultValue: map[ModelFieldConstants.defaultValue],
      placeholder: map[ModelFieldConstants.placeholder] != null
          ? TextInputPlaceholder.fromMap(map[ModelFieldConstants.placeholder])
          : null,
    );
  }

  @override
  bool validateResponse() {
    if (response == null || response == "") return false;
    return true;
  }
}
