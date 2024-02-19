import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[DateStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatDate]
class DateStyle extends BaseStyles {
  const DateStyle({
    this.textStyle,
    this.contentPadding,
    this.isTransparentBackground,
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

  ///[textStyle] gives style to the date to be displayed
  final TextStyle? textStyle;

  ///[contentPadding] set the content padding.
  final EdgeInsetsGeometry? contentPadding;

  ///set the container to be transparent.
  final bool? isTransparentBackground;



  /// Copies current [DateStyle] with some changes
  DateStyle copyWith({
    TextStyle? textStyle,
    EdgeInsetsGeometry? contentPadding,
    bool? isTransparentBackground,
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
  }) {
    return DateStyle(
      textStyle: textStyle ?? this.textStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      isTransparentBackground: isTransparentBackground ?? this.isTransparentBackground,
      height: height ?? this.height,
      width: width ?? this.width,
      background: background ?? this.background,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
    );
  }

  /// Merges current [DateStyle] with [other]
  DateStyle merge(DateStyle? other) {

    if (other == null) return this;
    return copyWith(
      textStyle: other.textStyle,
      contentPadding: other.contentPadding,
      isTransparentBackground: other.isTransparentBackground,
      height: other.height,
      width: other.width,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
    );
  }
}
