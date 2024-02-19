import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[DeletedBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatDeleteMessageBubble]
class DeletedBubbleStyle extends BaseStyles {
  const DeletedBubbleStyle({
    this.textStyle,
    this.borderColor,
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
  }) : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  ///[textStyle] delete message bubble text style
  final TextStyle? textStyle;

  ///[borderColor] border color of bubble
  final Color? borderColor;
}
