import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[StatusIndicatorStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatStatusIndicator]
class StatusIndicatorStyle extends BaseStyles {
  const StatusIndicatorStyle({
    double? width,
    double? height,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
  }) : super(
            width: width,
            height: height,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);
}
