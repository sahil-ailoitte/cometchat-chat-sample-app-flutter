import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[MessageInputStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatMessageInput]
class MessageInputStyle extends BaseStyles {
  const MessageInputStyle({
    this.textStyle,
    this.placeholderTextStyle,
    this.dividerTint,
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

  ///[textStyle]
  final TextStyle? textStyle;

  ///[placeholderTextStyle] hint text style
  final TextStyle? placeholderTextStyle;

  ///[dividerTint] provides color to the divider sepeating input field and bottom bar
  final Color? dividerTint;
}
