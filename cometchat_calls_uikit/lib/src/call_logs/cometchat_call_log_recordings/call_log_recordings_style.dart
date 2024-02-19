import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CallLogRecordingsStyle] is a data class that has styling-related properties for [CometChatCallLogRecordings]
/// ```dart
/// CallLogRecordingsStyle(
/// titleStyle: TextStyle(fontSize: 20),
/// subTitleStyle: TextStyle(fontSize: 16),
/// tailTitleStyle: TextStyle(fontSize: 14),
/// emptyTextStyle: TextStyle(fontSize: 14),
/// )
/// ```
class CallLogRecordingsStyle extends BaseStyles {
  ///[backIconTint] sets color for back icon
  final Color? backIconTint;

  ///[dividerTint] sets color for divider icon
  final Color? dividerTint;

  ///[titleStyle] sets TextStyle for title
  final TextStyle? titleStyle;

  ///[tailTitleStyle] sets TextStyle for tail text
  final TextStyle? tailTitleStyle;

  ///[recordingTitleStyle] sets TextStyle for recording title text
  final TextStyle? recordingTitleStyle;

  ///[emptyTextStyle] sets TextStyle for empty text style
  final TextStyle? emptyTextStyle;

  ///[durationTextStyle] sets TextStyle for duration text style
  final TextStyle? durationTextStyle;

  ///[downLoadIconTint] sets color for download icon
  final Color? downLoadIconTint;

  CallLogRecordingsStyle({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    this.titleStyle,
    this.dividerTint,
    this.emptyTextStyle,
    this.backIconTint,
    this.tailTitleStyle,
    this.recordingTitleStyle,
    this.durationTextStyle,
    this.downLoadIconTint,
  }) : super(
            width: width,
            height: height,
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  /// Copies current [CallLogRecordingsStyle] with some changes
  CallLogRecordingsStyle copyWith({
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
    Color? backIconTint,
    Color? dividerTint,
    Color? downLoadIconTint,
    TextStyle? titleStyle,
    TextStyle? tailTitleStyle,
    TextStyle? recordingTitleStyle,
    TextStyle? emptyTextStyle,
    TextStyle? durationTextStyle,
  }) {
    return CallLogRecordingsStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      backIconTint: backIconTint ?? this.backIconTint,
      dividerTint: dividerTint ?? this.dividerTint,
      titleStyle: titleStyle ?? this.titleStyle,
      tailTitleStyle: tailTitleStyle ?? this.tailTitleStyle,
      recordingTitleStyle: recordingTitleStyle ?? this.recordingTitleStyle,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      durationTextStyle: durationTextStyle ?? this.durationTextStyle,
      downLoadIconTint: downLoadIconTint ?? this.downLoadIconTint,
    );
  }

  /// Merges current [CallLogRecordingsStyle] with [other]
  CallLogRecordingsStyle mergeWith(CallLogRecordingsStyle? other) {
    if (other == null) return this;
    return CallLogRecordingsStyle(
      width: other.width,
      height: other.height,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
      backIconTint: other.backIconTint,
      dividerTint: other.dividerTint,
      titleStyle: other.titleStyle,
      tailTitleStyle: other.tailTitleStyle,
      recordingTitleStyle: other.recordingTitleStyle,
      emptyTextStyle: other.emptyTextStyle,
      durationTextStyle: other.durationTextStyle,
      downLoadIconTint: other.downLoadIconTint,
    );
  }
}
