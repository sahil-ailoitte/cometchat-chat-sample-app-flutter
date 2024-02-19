import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';


///[CallBubbleConfiguration] is a data class that has configuration properties
/// ```dart
/// CallBubbleConfiguration(
///  icon: Icon(Icons.call),
///  title: 'Call',
///  buttonText: 'Call',
///  onTap: (context) {
///  print('Call');
///  },
///  callBubbleStyle: CallBubbleStyle(
///  borderRadius: 8,
///  background: Colors.blue,
///  ),
///  theme: cometChatTheme,
///  alignment: BubbleAlignment.left,
///  );
class CallBubbleConfiguration {

  const CallBubbleConfiguration({
    this.icon,
    this.title,
    this.buttonText,
    this.onTap,
    this.callBubbleStyle,
    this.theme,
    this.alignment});

  ///[icon] to show in the leading view of the bubble
  final Widget? icon;

  ///[title] title to be displayed , default is ''
  final String? title;

  ///[buttonText] the text to be displayed on the button
  final String? buttonText;

  ///[onTap] to execute some task on tapping of the button
  final Function(BuildContext)? onTap;

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[callBubbleStyle] will be used to customize the appearance of the widget
  final CallBubbleStyle? callBubbleStyle;

  ///[alignment] will be used to align the widget to left or right of the CometChatMessageList
  final BubbleAlignment? alignment;
}