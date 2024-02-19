import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CallLogHistoryStyle] is a data class that has styling-related properties for [CometChatCallLogHistory]
/// ```dart
/// CallLogHistoryStyle(
/// titleStyle: TextStyle(fontSize: 20),
/// dateTextStyle: TextStyle(fontSize: 16),
/// statusTextStyle: TextStyle(fontSize: 14),
/// durationTextStyle: TextStyle(fontSize: 14),
/// )
/// ```
class CallLogHistoryStyle extends BaseStyles {
  ///[backIconTint] sets color for back icon
  final Color? backIconTint;

  ///[dividerTint] sets color for divider icon
  final Color? dividerTint;

  ///[titleStyle] sets TextStyle for title
  final TextStyle? titleStyle;

  ///[dateTextStyle] sets TextStyle for date separator text
  final TextStyle? dateTextStyle;

  ///[statusTextStyle] sets TextStyle for tile Title text
  final TextStyle? statusTextStyle;

  ///[durationTextStyle] sets TextStyle for tail text
  final TextStyle? durationTextStyle;

  ///[emptyTextStyle] sets TextStyle for empty text style
  final TextStyle? emptyTextStyle;

  ///[errorTextStyle] sets TextStyle for error text style
  final TextStyle? errorTextStyle;

  ///[loadingIconTint] sets color for loading icon
  final Color? loadingIconTint;

  CallLogHistoryStyle({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    this.titleStyle,
    this.dividerTint,
    this.emptyTextStyle,
    this.errorTextStyle,
    this.loadingIconTint,
    this.backIconTint,
    this.durationTextStyle,
    this.statusTextStyle,
    this.dateTextStyle,
  }) : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  /// Merges current [CallLogHistoryStyle] with [other]
  CallLogHistoryStyle mergeWith(CallLogHistoryStyle? other) {
    if (other == null) return this;
    return CallLogHistoryStyle(
      width: other.width,
      height: other.height,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
      titleStyle: other.titleStyle,
      dividerTint: other.dividerTint,
      emptyTextStyle: other.emptyTextStyle,
      errorTextStyle: other.errorTextStyle,
      loadingIconTint: other.loadingIconTint,
      backIconTint: other.backIconTint,
      durationTextStyle: other.durationTextStyle,
      statusTextStyle: other.statusTextStyle,
      dateTextStyle: other.dateTextStyle,
    );
  }

  /// Copies current [CallLogHistoryStyle] with some changes
  CallLogHistoryStyle copyWith({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    TextStyle? titleStyle,
    Color? dividerTint,
    TextStyle? emptyTextStyle,
    TextStyle? errorTextStyle,
    Color? loadingIconTint,
    Color? backIconTint,
    TextStyle? durationTextStyle,
    TextStyle? statusTextStyle,
    TextStyle? dateTextStyle,
  }) {
    return CallLogHistoryStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      titleStyle: titleStyle ?? this.titleStyle,
      dividerTint: dividerTint ?? this.dividerTint,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      loadingIconTint: loadingIconTint ?? this.loadingIconTint,
      backIconTint: backIconTint ?? this.backIconTint,
      durationTextStyle: durationTextStyle ?? this.durationTextStyle,
      statusTextStyle: statusTextStyle ?? this.statusTextStyle,
      dateTextStyle: dateTextStyle ?? this.dateTextStyle,
    );
  }
}
