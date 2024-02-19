import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[ButtonStyle] is a model class for button widget. It contains the styles for the button widget.
///
/// ```dart
/// ButtonStyle(
/// textStyle: TextStyle(),
/// iconTint: Colors.white,
/// iconBackground: Colors.white,
/// iconBorder: Border.all(),
/// iconBorderRadius: 50,
/// width: 100,
/// height: 100,
/// background: Colors.white,
/// border: Border.all(),
/// borderRadius: BorderRadius.circular(20),
/// gradient: LinearGradient(),
/// );
/// ```
///
class ButtonStyle extends BaseStyles {
  const ButtonStyle({
    this.textStyle,
    this.iconTint,
    this.iconBackground,
    this.iconBorder,
    this.iconBorderRadius,
    this.iconHeight,
    this.iconWidth,
    double? width,
    double? height,
    Color? background,
    BoxBorder? border,
    double? borderRadius,
    Gradient? gradient,
  }) : super(
            background: background,
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);

  ///[iconTint] sets color for icon
  final Color? iconTint;

  ///[iconBackground] sets background color for icon
  final Color? iconBackground;

  ///[iconBorder] sets border for icon
  final BoxBorder? iconBorder;

  ///[iconBorderRadius] sets border radius for icon
  final double? iconBorderRadius;

  ///[textStyle] sets TextStyle for text
  final TextStyle? textStyle;

///[iconHeight] sets height for icon
  final double? iconHeight;

///[iconWidth] sets width for icon
  final double? iconWidth;

  ///[iconPadding] sets padding for icon

}
