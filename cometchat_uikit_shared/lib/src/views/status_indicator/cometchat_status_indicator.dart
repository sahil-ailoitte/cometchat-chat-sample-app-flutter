import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CometChatStatusIndicator] is a widget that is used to indicate the online status of a [User]
/// ```dart
/// CometChatStatusIndicator(
///          backgroundColor: Colors.teal,
///          style: const StatusIndicatorStyle(
///            width: 40,
///            height: 40,
///          ),
///        );
/// ```
class CometChatStatusIndicator extends StatelessWidget {
  const CometChatStatusIndicator(
      {Key? key, this.backgroundImage, this.backgroundColor, this.style})
      : super(key: key);

  ///[backgroundImage] icon for status indicator
  final Widget? backgroundImage;

  final Color? backgroundColor;

  ///[style] contains properties that affects the appearance of this widget
  final StatusIndicatorStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style?.width ?? 14,
      height: style?.height ?? 14,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(style?.borderRadius ?? 7.0)),
          border: style?.border,
          color: backgroundColor,
          gradient: style?.gradient),
      child: backgroundImage,
    );
  }
}
