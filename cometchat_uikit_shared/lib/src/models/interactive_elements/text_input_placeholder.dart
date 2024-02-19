import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///placeholder model for Text field
class TextInputPlaceholder {

  ///text to be displayed in place
  String text;

  TextInputPlaceholder({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      ModelFieldConstants.text: text,
    };
  }

  factory TextInputPlaceholder.fromMap(dynamic map) {
    return TextInputPlaceholder(
      text: map[ModelFieldConstants.text],
    );
  }
}
