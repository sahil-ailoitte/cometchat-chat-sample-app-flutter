import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CallBubbleStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatCallBubble]
///
/// ```dart
///  CallBubbleStyle(
///  background: Colors.blue,
///  iconTint: Colors.grey,
///  titleStyle: TextStyle(
///  color: Colors.red,
///  fontSize: 16,
///  fontWeight: FontWeight.bold,
///  ),
///  subtitleStyle: TextStyle(
///  color: Colors.red,
///  fontSize: 14,
///  fontWeight: FontWeight.bold,
///  ),
///  buttonTextStyle: TextStyle(
///  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold
///  ),
///  );
///
class CallBubbleStyle extends BaseStyles {
  ///[CallBubbleStyle] constructor requires [titleStyle], [subtitleStyle], [buttonTextStyle], [iconTint] and [background] while initializing.
  const CallBubbleStyle({
    this.titleStyle,
    this.subtitleStyle,
    this.buttonTextStyle,
    this.buttonBackground,
    this.iconTint,
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

  ///[titleStyle] title text style
  final TextStyle? titleStyle;

  ///[subtitleStyle] subtitle text style
  final TextStyle? subtitleStyle;

  ///[buttonTextStyle] buttonText text style
  final TextStyle? buttonTextStyle;

  ///[iconTint] default Call bubble icon
  final Color? iconTint;

  ///[buttonBackground] sets the Call bubble button background
  final Color? buttonBackground;


  /// Copies current [CallBubbleStyle] with some changes
  CallBubbleStyle copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? buttonTextStyle,
    Color? buttonBackground,
    Color? iconTint,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    return CallBubbleStyle(
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      buttonBackground: buttonBackground ?? this.buttonBackground,
      iconTint: iconTint ?? this.iconTint,
      background: background ?? this.background,
      gradient: gradient ?? this.gradient,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  /// Merges current [CallBubbleStyle] with [other]
  CallBubbleStyle merge(CallBubbleStyle? other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: other.titleStyle,
      subtitleStyle: other.subtitleStyle,
      buttonTextStyle: other.buttonTextStyle,
      buttonBackground: other.buttonBackground,
      iconTint: other.iconTint,
      background: other.background,
      gradient: other.gradient,
      border: other.border,
      borderRadius: other.borderRadius,
      width: other.width,
      height: other.height,
    );
  }
}
