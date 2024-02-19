import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CallButtonsStyle] is the data class that contains style configuration for [CometChatCallButtons]
///
/// ```dart
/// CallButtonsStyle(
/// voiceCallIconTint: Colors.blue,
/// videoCallIconTint: Colors.blue,
/// width: 40,
/// height: 40,
/// background: Colors.white,
/// border: Border.all(color: Colors.blue),
/// borderRadius: 20,
/// gradient: null,
/// );
/// ```
///
class CallButtonsStyle extends BaseStyles {
  /// [CallButtonsStyle] constructor takes [voiceCallIconTint], [videoCallIconTint], [width], [height], [background], [border], [borderRadius] and [gradient] while initializing.
  const CallButtonsStyle({
    this.voiceCallIconTint,
    this.videoCallIconTint,
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

  ///[voiceCallIconTint] sets the color of the voice call icon
  final Color? voiceCallIconTint;

  ///[videoCallIconTint] sets the color of the video call icon
  final Color? videoCallIconTint;

}

extension ButtonStyling on CallButtonsStyle {

  copyWith({
    Color? voiceCallIconTint,
    Color? videoCallIconTint,
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
  }){
    return CallButtonsStyle(
      voiceCallIconTint: voiceCallIconTint ?? this.voiceCallIconTint,
      videoCallIconTint: videoCallIconTint ?? this.videoCallIconTint,
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
    );
  }

  ///[merge] method merges the current style with the given style.
    merge(CallButtonsStyle? style){
        return copyWith(
          voiceCallIconTint: style?.voiceCallIconTint,
          videoCallIconTint: style?.videoCallIconTint,
          width: style?.width,
          height: style?.height,
          background: style?.background,
          border: style?.border,
          borderRadius: style?.borderRadius,
          gradient: style?.gradient,
        );
      }

}