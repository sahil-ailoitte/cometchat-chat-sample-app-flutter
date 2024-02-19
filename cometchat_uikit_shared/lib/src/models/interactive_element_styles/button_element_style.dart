import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';


class ButtonElementStyle extends BaseStyles {
  ButtonElementStyle({
    this.buttonTextStyle,
    this.loadingIconTint,
    double? width,
    double? height,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
    double? borderRadius,
  }) : super(
      width: width,
      height: height,
      background: background,
      gradient: gradient,
      border: border,
      borderRadius: borderRadius);

  ///[buttonTextStyle] is a object of [TextStyle] which is used to set the style for the button text in the meeting bubble
  TextStyle? buttonTextStyle;

  ///[loadingIconTint] sets color for  loading icon
  final Color? loadingIconTint;

  ButtonElementStyle merge(ButtonElementStyle mergeWith) {
    return ButtonElementStyle(
      buttonTextStyle: buttonTextStyle ?? mergeWith.buttonTextStyle,
      width: width ?? mergeWith.width,
      height: height ?? mergeWith.height,
      background: background ?? mergeWith.background,
      border: border ?? mergeWith.border,
      borderRadius: borderRadius ?? mergeWith.borderRadius,
      gradient: gradient ?? mergeWith.gradient,
      loadingIconTint: loadingIconTint ?? mergeWith.loadingIconTint,
    );
  }
}
