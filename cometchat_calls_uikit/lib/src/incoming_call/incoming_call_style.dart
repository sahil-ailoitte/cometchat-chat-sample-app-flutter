import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

/// [IncomingCallStyle] is a data class that has styling-related properties
/// to customize the appearance of [CometChatIncomingCallScreen]
///
/// ```dart
/// IncomingCallStyle(
///  width: MediaQuery.of(context).size.width,
///  height: MediaQuery.of(context).size.height,
///  background: Colors.white,
///  gradient: null,
///  border: null,
///  borderRadius: 0,
///  );
///
class IncomingCallStyle extends BaseStyles{
  IncomingCallStyle({
    this.declineButtonTextStyle,
    this.acceptButtonTextStyle,
    double? width,
    double? height,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
    double? borderRadius,
}):super(
  width: width,
  height: height,
  background: background,
  gradient: gradient,
  border: border,
  borderRadius: borderRadius,
);

  ///[declineButtonTextStyle] is used to set a custom decline button text style
  final TextStyle? declineButtonTextStyle;

  ///[acceptButtonTextStyle] is used to set a custom accept button text style
  final TextStyle? acceptButtonTextStyle;

  IncomingCallStyle merge(IncomingCallStyle? style){
    return IncomingCallStyle(
      acceptButtonTextStyle: style?.acceptButtonTextStyle ?? acceptButtonTextStyle,
      declineButtonTextStyle: style?.declineButtonTextStyle ?? declineButtonTextStyle,
      width: style?.width ?? width,
      height: style?.height ?? height,
      background: style?.background ?? background,
      gradient: style?.gradient ?? gradient,
      border: style?.border ?? border,
      borderRadius: style?.borderRadius ?? borderRadius,
    );
  }
}