import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[ListItemStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatListItem]
class ListItemStyle extends BaseStyles {
  const ListItemStyle({
    this.titleStyle,
    this.separatorColor,
    this.padding,
    this.margin,
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

  ///[titleStyle] TextStyle for List item title
  final TextStyle? titleStyle;

  ///[separatorColor] customize the color of the horizontal line separating the list items
  final Color? separatorColor;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this paddin
  final EdgeInsetsGeometry? padding;

  /// Empty space to surround the [CometChatListItem].
  final EdgeInsetsGeometry? margin;

  copyWith({
    TextStyle? titleStyle,
    Color? separatorColor,
    double? width,
    double? height,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
    double? borderRadius,
  }) {
    return ListItemStyle(
      titleStyle: titleStyle ?? this.titleStyle,
      separatorColor: separatorColor ?? this.separatorColor,
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      gradient: gradient ?? this.gradient,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  merge(ListItemStyle? style) {
    if (style == null) return this;
    return copyWith(
      titleStyle: style.titleStyle,
      separatorColor: style.separatorColor,
      width: style.width,
      height: style.height,
      background: style.background,
      gradient: style.gradient,
      border: style.border,
      borderRadius: style.borderRadius,
    );
  }
}
