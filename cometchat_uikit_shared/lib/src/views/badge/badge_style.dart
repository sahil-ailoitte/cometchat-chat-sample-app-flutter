import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[BadgeStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatBadge]
class BadgeStyle extends BaseStyles {
  const BadgeStyle({
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

  ///[textStyle] gives style to count
  final TextStyle? textStyle;
}
