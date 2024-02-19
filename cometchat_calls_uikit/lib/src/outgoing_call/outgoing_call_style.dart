import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

/// [OutgoingCallStyle] is the data class that contains style configuration for [CometChatOutgoingCall]
///
/// ```dart
/// OutgoingCallStyle(
/// declineButtonTextStyle: TextStyle(color: Colors.white),
/// background: Colors.blue,
/// gradient: null,
/// );
/// ```
///
class OutgoingCallStyle extends BaseStyles{
  OutgoingCallStyle({
    this.declineButtonTextStyle,
    double? width,
    double? height,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
    double? borderRadius})
      :super(
    width: width,
    height: height,
    background: background,
    gradient: gradient,
    border: border,
    borderRadius: borderRadius,
  );

  ///[declineButtonTextStyle] is used to define the decline button style for the widget.
  final TextStyle? declineButtonTextStyle;

  OutgoingCallStyle merge(OutgoingCallStyle? style){
    return OutgoingCallStyle(
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