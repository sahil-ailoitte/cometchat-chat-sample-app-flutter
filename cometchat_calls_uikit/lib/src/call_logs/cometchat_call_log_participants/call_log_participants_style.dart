import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CallLogParticipantsStyle] is a data class that has styling-related properties for [CometChatCallLogParticipants]
/// ```dart
/// CallLogParticipantsStyle(
/// titleStyle: TextStyle(fontSize: 20),
/// subTitleStyle: TextStyle(fontSize: 16),
///  tailTitleStyle: TextStyle(fontSize: 14),
///  emptyTextStyle: TextStyle(fontSize: 14),
///  )
///  ```
class CallLogParticipantsStyle extends BaseStyles {
  ///[backIconTint] sets color for close icon
  final Color? backIconTint;

  ///[titleStyle] sets TextStyle for title
  final TextStyle? titleStyle;

  ///[subTitleStyle] sets TextStyle for title
  final TextStyle? subTitleStyle;

  ///[tailTitleStyle] sets TextStyle for title
  final TextStyle? tailTitleStyle;

  ///[nameTextStyle] sets TextStyle for name
  final TextStyle? nameTextStyle;

  ///[emptyTextStyle] sets TextStyle for empty text style
  final TextStyle? emptyTextStyle;

  CallLogParticipantsStyle({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    this.titleStyle,
    this.subTitleStyle,
    this.emptyTextStyle,
    this.backIconTint,
    this.tailTitleStyle,
    this.nameTextStyle,
  }) : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  /// Merges current [CallLogParticipantsStyle] with [other]
  CallLogParticipantsStyle mergeWith(CallLogParticipantsStyle? other) {
    if (other == null) return this;
    return CallLogParticipantsStyle(
      width: other.width,
      height: other.height,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
      titleStyle: other.titleStyle,
      subTitleStyle: other.subTitleStyle,
      emptyTextStyle: other.emptyTextStyle,
      backIconTint: other.backIconTint,
      tailTitleStyle: other.tailTitleStyle,
      nameTextStyle: other.nameTextStyle,
    );
  }

  /// Copies current [CallLogParticipantsStyle] with some changes
  CallLogParticipantsStyle copyWith({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    TextStyle? emptyTextStyle,
    Color? backIconTint,
    TextStyle? tailTitleStyle,
    TextStyle? nameTextStyle,
  }) {
    return CallLogParticipantsStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      titleStyle: titleStyle ?? this.titleStyle,
      subTitleStyle: subTitleStyle ?? this.subTitleStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      backIconTint: backIconTint ?? this.backIconTint,
      tailTitleStyle: tailTitleStyle ?? this.tailTitleStyle,
      nameTextStyle: nameTextStyle ?? this.nameTextStyle,
    );
  }
}
