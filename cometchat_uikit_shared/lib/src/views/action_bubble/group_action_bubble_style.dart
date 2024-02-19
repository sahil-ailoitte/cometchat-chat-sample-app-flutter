import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

class GroupActionBubbleStyle extends BaseStyles {
  const GroupActionBubbleStyle({
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

  ///[textStyle] text style of group action message
  final TextStyle? textStyle;
}
