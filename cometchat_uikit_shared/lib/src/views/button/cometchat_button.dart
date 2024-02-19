import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'button_style.dart' as cometchat_btn_style;


/// [CometChatButton] is a button widget with customizable styles.
/// Use this widget along with [cometchat_btn_style.ButtonStyle] to modify the default style.
///
/// ```dart
/// CometChatButton(
///  text: "Button",
///  buttonStyle: CometChatButtonStyle(
///  background: Colors.red,
///  ),
///  onTap: (context) {
///  //Action on button tap goes here
///  },
///  );
///  ```
///
class CometChatButton extends StatelessWidget {
  const CometChatButton(
      {Key? key,
      this.text,
      this.hoverText,
      this.iconUrl,
      this.iconPackage,
      this.buttonStyle,
      this.onTap})
      : super(key: key);

  ///[text] is a string which sets the text for the button
  final String? text;
  ///[hoverText] is a string which sets the hover text for the button
  final String? hoverText;
  ///[iconUrl] is a string which sets the url for the icon
  final String? iconUrl;
  ///[iconPackage] is a string which sets the package name for the icon
  final String? iconPackage;
  ///[buttonStyle] is a object of [cometchat_btn_style.ButtonStyle] which sets the style for the button
  final cometchat_btn_style.ButtonStyle? buttonStyle;
  ///[onTap] is a callback which gets called when button is clicked
  final Function(BuildContext)? onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          height: buttonStyle?.height,
          width: buttonStyle?.width,
          decoration: BoxDecoration(
            color: buttonStyle?.background,
            gradient: buttonStyle?.gradient,
            border: buttonStyle?.border,
            borderRadius: BorderRadius.circular(buttonStyle?.borderRadius ?? 50),
          ),
          child: IconButton(
            onPressed: () {
              if (onTap != null) {
                onTap!(context);
              }
            },
            icon: iconUrl != null
                ? DecoratedBox(decoration: BoxDecoration(
              color: buttonStyle?.iconBackground,
              border: buttonStyle?.iconBorder,
            ),
            child: Image.asset(
              iconUrl!,
              package: iconPackage ?? UIConstants.packageName,
              color: buttonStyle?.iconTint,
              height: buttonStyle?.iconHeight,
              width: buttonStyle?.iconWidth,
            )
            )
                : const Text(''),
            tooltip: hoverText,
          ),
        ),
        if (text != null)
          Text(
            text!,
            style: buttonStyle?.textStyle,
          )
      ],
    );
  }
}
