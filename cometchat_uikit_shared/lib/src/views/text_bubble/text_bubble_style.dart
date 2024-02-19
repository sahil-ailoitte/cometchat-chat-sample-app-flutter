import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[TextBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatTextBubble]
class TextBubbleStyle extends BaseStyles {
  const TextBubbleStyle({
    this.textStyle,
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

  ///[textStyle] provides style to text
  final TextStyle? textStyle;
}
