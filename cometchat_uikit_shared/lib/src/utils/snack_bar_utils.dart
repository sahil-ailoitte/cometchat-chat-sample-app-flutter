import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class SnackBarUtils{

  static show(String text, BuildContext context ,{SnackBarConfiguration? snackBarConfiguration, CometChatTheme? theme }){
    
    SnackBar snackBar = SnackBar(
      backgroundColor: snackBarConfiguration?.backgroundColor?? theme?.palette.getAccent() ??cometChatTheme.palette.getAccent(),
      elevation: snackBarConfiguration?.elevation,
      margin: snackBarConfiguration?.margin,
      padding: snackBarConfiguration?.padding,
      duration: snackBarConfiguration?.duration??const Duration(seconds: 2),
      content: Center(child: Text(text, style:
      snackBarConfiguration?.contentTextStyle??
          TextStyle(color: theme?.palette.getBackground()?? cometChatTheme.palette.getBackground(),
            fontSize: theme?.typography.caption1.fontSize,
            fontFamily: theme?.typography.caption1.fontFamily,
            fontWeight: theme?.typography.caption1.fontWeight,

          ), ), ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }

}