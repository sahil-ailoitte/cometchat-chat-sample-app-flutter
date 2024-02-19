import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[VideoBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatVideoBubble]
class VideoBubbleStyle extends BaseStyles {
  const VideoBubbleStyle({
    this.playIconTint,
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

  ///[playIconTint] provides color to the video play icon
  final Color? playIconTint;
}
