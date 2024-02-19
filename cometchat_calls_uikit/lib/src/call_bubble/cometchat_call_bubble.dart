import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [CometChatCallBubble] is a widget that displays the call information and a button to join the call.
///
/// ```dart
/// CometChatCallBubble(
///  icon: Icon(Icons.call),
///  title: 'Call',
///  buttonText: 'Call',
///  onTap: (context) {
///  print('Call');
///  },
///  callBubbleStyle: CallBubbleStyle(
///  background: Colors.blue,
///  iconTint: Colors.grey,
///  titleStyle: TextStyle(
///  color: Colors.red,
///  fontSize: 16,
///  fontWeight: FontWeight.bold,
///  ),
///  subtitleStyle: TextStyle(
///  color: Colors.red,
///  fontSize: 14,
///  fontWeight: FontWeight.bold,
///  ),
///  buttonTextStyle: TextStyle(
///  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold
///  ),
///  ),
///  theme: cometChatTheme,
///  alignment: BubbleAlignment.left,
///  );
///
class CometChatCallBubble extends StatelessWidget {
  /// [CometChatCallBubble] constructor requires [icon], [title], [onClick], [callBubbleStyle] and [theme] while initializing.
  const CometChatCallBubble(
      {Key? key,
      this.icon,
      this.title,
        this.buttonText,
      this.onTap,
      this.callBubbleStyle,
      this.theme,
      this.alignment})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    CometChatTheme currentTheme = theme ?? cometChatTheme;
    return Container(
      height: callBubbleStyle?.height,
      constraints: BoxConstraints(
          maxWidth: callBubbleStyle?.width ?? MediaQuery.of(context).size.width * 61.8 / 100,

      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(callBubbleStyle?.borderRadius??0),
        border: callBubbleStyle?.border,
        gradient: callBubbleStyle?.gradient,
        color: callBubbleStyle?.background ?? currentTheme.palette.getAccent50(),
      ),
      padding: const EdgeInsets.only(top: 3, left: 3, right: 3),
      child: ListTile(
        contentPadding: const EdgeInsets.only(top: 3, left: 3, right: 3),
        horizontalTitleGap: 0,
        minLeadingWidth: 0,
        // leading: icon,
        title: Row(
          children: [
            icon ?? Image.asset(
              AssetConstants.videoCall,
              package: UIConstants.packageName,
              color: callBubbleStyle?.iconTint ?? ( alignment == BubbleAlignment.left
                  ? currentTheme.palette.getPrimary()
                  : currentTheme.palette.backGroundColor.light),
              height: 36,
              width: 36,
            ),
            const Spacer(),
            Flexible(
              flex: 17,
              child: Text(
                title ?? '',
                style: TextStyle(
                        color:alignment == BubbleAlignment.left
                            ? currentTheme.palette.getAccent()
                            : currentTheme.palette.backGroundColor.light,
                        fontSize: currentTheme.typography.text1.fontSize,
                        fontWeight: currentTheme.typography.text1.fontWeight)
                    .merge(callBubbleStyle?.titleStyle),
              ),
            ),
          ],
        ),

        subtitle: ElevatedButton(
          onPressed: () {
            if (onTap != null) {

              onTap!(context);
            }
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: callBubbleStyle?.buttonBackground ??( alignment == BubbleAlignment.left
                    ? currentTheme.palette.getPrimary()
                    : currentTheme.palette.backGroundColor.light),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.18),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 9)
            ),
            child: Text(
              buttonText ?? Translations.of(context).join.toUpperCase(),
              style: TextStyle(
                  color: alignment == BubbleAlignment.left
                      ? currentTheme.palette.backGroundColor.light
                      : currentTheme.palette.getPrimary(),
                  fontSize: currentTheme.typography.text2.fontSize,
                  fontWeight: currentTheme.typography.text2.fontWeight).merge(callBubbleStyle?.buttonTextStyle),
            )
        ),
      ),
    );
  }
}
