import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[ImageBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatImageBubble]
class ImageBubbleStyle extends BaseStyles {
  const ImageBubbleStyle(
      {double? width,
      double? height,
      Color? background,
      BoxBorder? border,
      double? borderRadius,
      Gradient? gradient,
      this.captionStyle})
      : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  ///[captionStyle] provides styling to the caption text
  final TextStyle? captionStyle;
}
