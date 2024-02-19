import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class CheckBoxElementStyle extends BaseStyles {
  CheckBoxElementStyle({
    this.labelStyle,
    this.activeColor,
    this.checkColor,
    this.optionTextStyle,
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

  final TextStyle? labelStyle;
  final Color? activeColor;
  final Color? checkColor;
  final TextStyle? optionTextStyle;

  CheckBoxElementStyle merge(CheckBoxElementStyle mergeWith) {
    return CheckBoxElementStyle(
      labelStyle: labelStyle ?? mergeWith.labelStyle,
      activeColor: activeColor ?? mergeWith.activeColor,
      checkColor: checkColor ?? mergeWith.checkColor,
      optionTextStyle: optionTextStyle ?? mergeWith.optionTextStyle,
      width: width ?? mergeWith.width,
      height: height ?? mergeWith.height,
      background: background ?? mergeWith.background,
      border: border ?? mergeWith.border,
      borderRadius: borderRadius ?? mergeWith.borderRadius,
      gradient: gradient ?? mergeWith.gradient,
    );
  }
}