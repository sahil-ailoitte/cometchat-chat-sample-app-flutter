import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CometChatCallLogDetailsOption] is a model class which contains information about options available for every [CometChatCallLogDetails]
///
/// ```dart
///
/// CometChatCallLogDetailsOption option = CometChatCallLogDetailsOption(
///   id: 'option1',
///   title: 'Option 1',
///   icon: 'icon_url',
///   packageName: 'com.example.package',
///   titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
///   customView: Container(
///     height: 100,
///     width: 100,
///     color: Colors.red,
///   ),
///   tail: Icon(Icons.arrow_forward),
///   height: 50.0,
///   onClick: (CallLog? callLog, String section, CometChatCallDetailProtocolController state) {
///     // do something on click
///   },
/// );
///
/// ```
class CometChatCallLogDetailsOption extends CometChatBaseOptions {
  ///to pass custom view to options
  Widget? customView;

  /// to pass tail component for detail option
  Widget? tail;

  ///to pass height for details
  double? height;

  ///[onClick] call function which takes 3 parameter , and one of user or group is populated at a time
  Function(CallLog? callLog, String section,
      CometChatCallLogDetailProtocolController state)? onClick;

  ///[CometChatCallLogDetailsOption] constructor requires [id] , [title] and [onClick] while initializing.
  CometChatCallLogDetailsOption(
      {this.customView,
        this.onClick,
        this.tail,
        required String id,
        this.height,
        String? title,
        String? icon,
        String? packageName,
        TextStyle? titleStyle})
      : super(
      id: id,
      icon: icon,
      packageName: packageName,
      title: title,
      titleStyle: titleStyle);

  @override
  String toString() {
    return 'DetailOption{customView: $customView, tail: $tail, onClick: $onClick , id $id , title $title ';
  }
}
