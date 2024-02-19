import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CardBubbleStyle] is a model class for card widget. It contains the styles for the card widget.
///
/// ```dart
/// CardStyle(
/// titleStyle: TextStyle(),
/// subtitleStyle: TextStyle(),
/// width: 100,
/// height: 100,
/// background: Colors.white,
/// border: Border.all(),
/// borderRadius: BorderRadius.circular(20),
/// gradient: LinearGradient(),
/// );
/// ```
///
class CardBubbleStyle extends BaseStyles {
  const CardBubbleStyle({
    this.buttonStyle,
    this.textStyle,
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

  ///[textStyle] sets TextStyle for subtitle
  final TextStyle? textStyle;

  ///[buttonStyle] sets submitButtonStyle for subtitle
  final ButtonElementStyle? buttonStyle;
}
