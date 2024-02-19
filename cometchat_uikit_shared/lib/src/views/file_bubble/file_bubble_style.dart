import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[FileBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatFileBubble]
class FileBubbleStyle extends BaseStyles {
  const FileBubbleStyle(
      {this.titleStyle,
      this.subtitleStyle,
      double? width,
      double? height,
      Color? background,
      BoxBorder? border,
      double? borderRadius,
      Gradient? gradient,
      this.downloadIconTint})
      : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  ///[titleStyle] file name text style
  final TextStyle? titleStyle;

  ///[subtitleStyle] subtitle text style
  final TextStyle? subtitleStyle;

  ///[downloadIconTint] video play pause icon
  final Color? downloadIconTint;
}
