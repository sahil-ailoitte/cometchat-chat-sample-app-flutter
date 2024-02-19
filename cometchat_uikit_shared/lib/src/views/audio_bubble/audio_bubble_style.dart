import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[AudioBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatAudioBubble]
class AudioBubbleStyle extends BaseStyles {
  const AudioBubbleStyle({
    this.titleStyle,
    this.subtitleStyle,
    this.playIconTint,
    this.pauseIconTint,
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

  ///[titleStyle] file name text style
  final TextStyle? titleStyle;

  ///[subtitleStyle] subtitle text style
  final TextStyle? subtitleStyle;

  ///[playIconTint] provides color to the video play icon
  final Color? playIconTint;

  ///[pauseIconTint] provides color to the video play icon
  final Color? pauseIconTint;
}
