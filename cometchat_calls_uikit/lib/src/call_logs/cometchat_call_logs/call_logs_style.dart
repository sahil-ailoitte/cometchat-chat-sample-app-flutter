import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CallLogsStyle] is a data class that has styling-related properties for [CometChatCallLogs]
/// ```dart
/// CallLogsStyle(
///  titleStyle: TextStyle(fontSize: 20),
///  subTitleStyle: TextStyle(fontSize: 16),
///  tailTitleStyle: TextStyle(fontSize: 14),
///  emptyTextStyle: TextStyle(fontSize: 14),
///  errorTextStyle: TextStyle(fontSize: 14),
///  )
///  ```
class CallLogsStyle extends BaseStyles {
  ///[backIconTint] sets color for back icon
  final Color? backIconTint;

  ///[infoIconTint] sets color for info icon
  final Color? infoIconTint;

  ///[titleStyle] sets TextStyle for title
  final TextStyle? titleStyle;

  ///[subTitleStyle] sets TextStyle for sub title
  final TextStyle? subTitleStyle;

  ///[tailTitleStyle] sets TextStyle for tail title
  final TextStyle? tailTitleStyle;

  ///[emptyTextStyle] sets TextStyle for empty text style
  final TextStyle? emptyTextStyle;

  ///[errorTextStyle] sets TextStyle for error text style
  final TextStyle? errorTextStyle;

  ///[loadingIconTint] sets color for loading icon
  final Color? loadingIconTint;

  ///[callStatusIconTint] sets color for call Status icon
  final Color? callStatusIconTint;

  CallLogsStyle({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    this.titleStyle,
    this.subTitleStyle,
    this.emptyTextStyle,
    this.errorTextStyle,
    this.loadingIconTint,
    this.backIconTint,
    this.infoIconTint,
    this.callStatusIconTint,
    this.tailTitleStyle,
  }) : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  /// Copies current [CallLogsStyle] with some changes
  CallLogsStyle copyWith({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    Color? backIconTint,
    Color? infoIconTint,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    TextStyle? tailTitleStyle,
    TextStyle? emptyTextStyle,
    TextStyle? errorTextStyle,
    Color? loadingIconTint,
    Color? callStatusIconTint,
  }) {
    return CallLogsStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      backIconTint: backIconTint ?? this.backIconTint,
      infoIconTint: infoIconTint ?? this.infoIconTint,
      titleStyle: titleStyle ?? this.titleStyle,
      subTitleStyle: subTitleStyle ?? this.subTitleStyle,
      tailTitleStyle: tailTitleStyle ?? this.tailTitleStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      loadingIconTint: loadingIconTint ?? this.loadingIconTint,
      callStatusIconTint: callStatusIconTint ?? this.callStatusIconTint,
    );
  }

  /// Merges current [CallLogsStyle] with [other]
  CallLogsStyle mergeWith(CallLogsStyle? other) {
    if (other == null) return this;
    return copyWith(
      width: other.width,
      height: other.height,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
      backIconTint: other.backIconTint,
      infoIconTint: other.infoIconTint,
      titleStyle: other.titleStyle,
      subTitleStyle: other.subTitleStyle,
      tailTitleStyle: other.tailTitleStyle,
      emptyTextStyle: other.emptyTextStyle,
      errorTextStyle: other.errorTextStyle,
      loadingIconTint: other.loadingIconTint,
      callStatusIconTint: other.callStatusIconTint,
    );
  }
}
