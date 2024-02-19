
import 'package:flutter/material.dart';

import '../../../cometchat_uikit_shared.dart';

class DecoratedContainerStyle extends BaseStyles{


  const DecoratedContainerStyle({
    this.margin,
    this.padding,
    this.titleStyle,
    this.contentStyle,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
  }) : super(
      background: background,
      border: border,
      borderRadius: borderRadius,
      gradient: gradient);




  final TextStyle? contentStyle;

  final TextStyle? titleStyle;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;



  /// Merges current [AIConversationSummaryStyle] with [other]
  DecoratedContainerStyle merge(DecoratedContainerStyle? other) {
    if (other == null) return this;
    return DecoratedContainerStyle(
      contentStyle: other.contentStyle,
      titleStyle: other.titleStyle,
      padding: other.padding,
      margin: other.margin,
      background: other.background,
      border: other.border,
      borderRadius: other.borderRadius,
      gradient: other.gradient,
    );
  }

}