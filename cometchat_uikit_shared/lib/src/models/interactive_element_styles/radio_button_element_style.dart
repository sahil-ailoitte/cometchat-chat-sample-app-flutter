import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class RadioButtonElementStyle extends BaseStyles {
  RadioButtonElementStyle({
    this.activeColor,
    this.labelStyle,
    this.optionTextStyle,
    this.radioColor,
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

  TextStyle? optionTextStyle;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final Color? radioColor;

  RadioButtonElementStyle merge(RadioButtonElementStyle mergeWith) {
    return RadioButtonElementStyle(
      optionTextStyle: optionTextStyle ?? mergeWith.optionTextStyle,
      labelStyle: labelStyle ?? mergeWith.labelStyle,
      activeColor: activeColor ?? mergeWith.activeColor,
      width: width ?? mergeWith.width,
      height: height ?? mergeWith.height,
      background: background ?? mergeWith.background,
      border: border ?? mergeWith.border,
      borderRadius: borderRadius ?? mergeWith.borderRadius,
      gradient: gradient ?? mergeWith.gradient,
      radioColor: radioColor ?? mergeWith.radioColor,
    );
  }
}
