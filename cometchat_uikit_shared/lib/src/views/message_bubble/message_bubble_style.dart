import 'package:flutter/material.dart';
import '../../../../cometchat_uikit_shared.dart';

///[MessageBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatMessageBubble]
class MessageBubbleStyle extends BaseStyles {
  ///[MessageBubbleStyle] constructor requires [width], [height], [background], [border], [borderRadius], [gradient] and [contentPadding] while initializing.
  const MessageBubbleStyle(
      {double? width,
      double? height,
      Color? background,
      BoxBorder? border,
      double? borderRadius,
      Gradient? gradient,
      this.widthFlex,
      this.contentPadding})
      : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  ///[contentPadding] sets padding for the bubble
  final EdgeInsets? contentPadding;

  ///[widthFlex] gives flex to the message bubble
  final double? widthFlex;
}
