import '../../../../cometchat_uikit_shared.dart';

/// Represents a dropdown model class , used to draw dropdown .
class DropdownElement extends BaseInputElement<String> {
  DropdownElement(
      {String elementType = UIElementTypeConstants.dropdown,
      required String elementId,
      required this.label,
      required this.options,
      String? response,
      String? defaultValue,
      bool? optional})
      : super(
            elementType: elementType,
            elementId: elementId,
            response: response,
            defaultValue: defaultValue,
            optional: optional ?? true);

  String label;
  List<OptionElement> options;

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map[ModelFieldConstants.label] = label;
    map[ModelFieldConstants.options] =
        options.map((option) => option.toMap()).toList();
    // map[ModelColumns.response] = response;
    return map;
  }

  factory DropdownElement.fromMap(dynamic map) {
    return DropdownElement(
      elementType: map[ModelFieldConstants.elementType],
      elementId: map[ModelFieldConstants.elementId],
      optional: map[ModelFieldConstants.optional],
      label: map[ModelFieldConstants.label],
      defaultValue: map[ModelFieldConstants.defaultValue],
      response: map[ModelFieldConstants.response],
      options: (map[ModelFieldConstants.options]??[] as List)
          .map<OptionElement>((optionMap) => OptionElement.fromMap(optionMap))
          .toList(),
    );
  }

  @override
  bool validateResponse() {
    if (response == null) return false;

    return true;
  }
}
