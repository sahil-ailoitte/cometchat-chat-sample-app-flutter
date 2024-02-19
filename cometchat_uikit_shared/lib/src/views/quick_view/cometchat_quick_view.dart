import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';


/// The [CometChatQuickView] widget is used to display a quick view with a title and an optional subtitle.
/// You can customize the appearance of the title and subtitle using the [titleTextStyle] and [subtitleTextStyle] parameters.
///
/// If no [background] color is provided, it defaults to white.
class CometChatQuickView extends StatelessWidget {
  const CometChatQuickView({Key? key,
    required this.title,
    this.subtitle,
    this.theme ,
    this.quickViewStyle
  }):super(key: key);

  /// The main title displayed in the quick view.
  final String title;

  /// An optional subtitle displayed below the title.
  final String? subtitle;

  /// Set the theme for cometchat
  final CometChatTheme? theme;

  ///Sets the style for quick view
  final QuickViewStyle? quickViewStyle;

  @override
  Widget build(BuildContext context) {

    CometChatTheme _theme;

    _theme= theme??cometChatTheme;

    return  Row(
      children: [
        Expanded(
          child: Container(
            decoration:  BoxDecoration(
                color: quickViewStyle?.background?? _theme.palette.getBackground(),
                shape: BoxShape.rectangle,
                border: quickViewStyle?.border,
                borderRadius:BorderRadius.all(Radius.circular(quickViewStyle?.borderRadius??4.0)),
            ),
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration:  BoxDecoration(
                color: quickViewStyle?.background?? Colors.white,
                shape: BoxShape.rectangle,
                   border:  Border(
                    left: BorderSide(
                      color: quickViewStyle?.leadingBarTint?? _theme.palette.getPrimary(), // Border color
                      width: quickViewStyle?.leadingBarWidth??4.0, // Border width
                    ),
                  )
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      title, style:  TextStyle(
                    fontSize:   _theme.typography.text2.fontSize,
                      fontWeight:_theme.typography.text2.fontWeight,
                    fontFamily: _theme.typography.text2.fontFamily,
                    color: _theme.palette.getPrimary(),
                  ).merge(quickViewStyle?.titleStyle)),
                  const SizedBox(height: 4.0,),
                  if(subtitle!=null) Text(subtitle!, style:
                  TextStyle(
                      fontSize: _theme.typography.subtitle2.fontSize,
                      fontWeight: _theme.typography.subtitle2.fontWeight,
                      fontFamily:
                      _theme.typography.subtitle2.fontFamily,
                      color:_theme.palette.getAccent()
                  ).merge(quickViewStyle?.subtitleStyle))
                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}
