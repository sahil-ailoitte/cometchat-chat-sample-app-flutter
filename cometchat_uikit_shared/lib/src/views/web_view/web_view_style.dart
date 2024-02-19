import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class WebViewStyle extends BaseStyles{

  const WebViewStyle({
    this.titleStyle,
    this.appBarColor,
    this.backIconColor,
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



  ///[titleStyle]  text style
  final TextStyle? titleStyle;


  ///[appBarColor] , default is Color(0xffFFFFFF)
  final Color? appBarColor;

  ///[backIconColor] , default is Color(0xff3399FF)
  final Color? backIconColor;


  WebViewStyle merge(WebViewStyle mergeWith) {
    return WebViewStyle(
      titleStyle: titleStyle ?? mergeWith.titleStyle,
      appBarColor: appBarColor ?? mergeWith.appBarColor,
      backIconColor: backIconColor ?? mergeWith.backIconColor,
      width: width ?? mergeWith.width,
      height: height ?? mergeWith.height,
      background: background ?? mergeWith.background,
      border: border ?? mergeWith.border,
      borderRadius: borderRadius ?? mergeWith.borderRadius,
      gradient: gradient ?? mergeWith.gradient,
    );
  }

}