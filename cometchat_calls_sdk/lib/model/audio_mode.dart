import 'dart:core';

class AudioMode{
  String? mode;
  bool? isSelectedValue;

  AudioMode({this.mode, this.isSelectedValue});

  String? getMode() {
    return mode;
  }

  void setMode(String type) {
    mode = type;
  }

  bool? isSelected() {
    return isSelectedValue;
  }

  void setSelected(bool selected) {
    isSelectedValue = selected;
  }

  factory AudioMode.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of action map is null');
    return AudioMode(
      mode: map['mode'],
      isSelectedValue: map['isSelectedValue'],
    );
  }

}
