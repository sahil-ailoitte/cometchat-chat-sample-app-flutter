import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CallLogDetailsStyle] is a data class that has styling-related properties for [CometChatCallLogDetails]
///
///  ```dart
///  CallLogDetailsStyle(
///     titleStyle: TextStyle(fontSize: 20),
///     nameStyle: TextStyle(fontSize: 16),
///     separatorDateStyle: TextStyle(fontSize: 14),
///     )
///
class CallLogDetailsStyle extends BaseStyles {
  const CallLogDetailsStyle(
      {this.titleStyle,
      this.backIconTint,
      this.voiceCallIconTint,
      this.videoCallIconTint,
      this.arrowIconTint,
      this.callStatusStyle,
      this.durationStyle,
      this.nameStyle,
      this.separatorDateStyle,
      this.timeStyle,
      this.countStyle,
      double? width,
      double? height,
      Color? background,
      Gradient? gradient,
      BoxBorder? border})
      : super(
            height: height,
            background: background,
            gradient: gradient,
            border: border);

  ///[titleStyle] provides styling for title text
  final TextStyle? titleStyle;

  ///[nameStyle] provides styling for name text
  final TextStyle? nameStyle;

  ///[separatorDateStyle] provides styling for separator date text
  final TextStyle? separatorDateStyle;

  ///[timeStyle] provides styling for time text
  final TextStyle? timeStyle;

  ///[durationStyle] provides styling for duration text
  final TextStyle? durationStyle;

  ///[countStyle] provides styling for count text
  final TextStyle? countStyle;

  ///[callStatusStyle] provides styling for call status text
  final TextStyle? callStatusStyle;

  ///[backIconTint] provide color to back button
  final Color? backIconTint;

  ///[arrowIconTint] provide color to arrow button
  final Color? arrowIconTint;

  ///[videoCallIconTint] provide color to back button
  final Color? videoCallIconTint;

  ///[voiceCallIconTint] provide color to back button
  final Color? voiceCallIconTint;

  /// Copies current [CallLogDetailsStyle] with some changes
  CallLogDetailsStyle copyWith({
    TextStyle? titleStyle,
    TextStyle? nameStyle,
    TextStyle? separatorDateStyle,
    TextStyle? timeStyle,
    TextStyle? durationStyle,
    TextStyle? countStyle,
    TextStyle? callStatusStyle,
    Color? backIconTint,
    Color? arrowIconTint,
    Color? videoCallIconTint,
    Color? voiceCallIconTint,
    double? width,
    double? height,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
  }) {
    return CallLogDetailsStyle(
      titleStyle: titleStyle ?? this.titleStyle,
      nameStyle: nameStyle ?? this.nameStyle,
      separatorDateStyle: separatorDateStyle ?? this.separatorDateStyle,
      timeStyle: timeStyle ?? this.timeStyle,
      durationStyle: durationStyle ?? this.durationStyle,
      countStyle: countStyle ?? this.countStyle,
      callStatusStyle: callStatusStyle ?? this.callStatusStyle,
      backIconTint: backIconTint ?? this.backIconTint,
      arrowIconTint: arrowIconTint ?? this.arrowIconTint,
      videoCallIconTint: videoCallIconTint ?? this.videoCallIconTint,
      voiceCallIconTint: voiceCallIconTint ?? this.voiceCallIconTint,
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      gradient: gradient ?? this.gradient,
      border: border ?? this.border,
    );
  }

  /// Merges current [CallLogDetailsStyle] with [other]
  CallLogDetailsStyle merge(CallLogDetailsStyle? other) {
    if (other == null) return this;
    return copyWith(
      titleStyle: other.titleStyle,
      nameStyle: other.nameStyle,
      separatorDateStyle: other.separatorDateStyle,
      timeStyle: other.timeStyle,
      durationStyle: other.durationStyle,
      countStyle: other.countStyle,
      callStatusStyle: other.callStatusStyle,
      backIconTint: other.backIconTint,
      arrowIconTint: other.arrowIconTint,
      videoCallIconTint: other.videoCallIconTint,
      voiceCallIconTint: other.voiceCallIconTint,
      width: other.width,
      height: other.height,
      background: other.background,
      gradient: other.gradient,
      border: other.border,
    );
  }
}
