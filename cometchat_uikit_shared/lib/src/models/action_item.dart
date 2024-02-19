import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[ActionItem] is the type of items displayed in [CometChatActionSheet]
///
/// ```dart
///
/// ActionItem item = ActionItem(
///   id: '1',
///   title: 'Like',
///   iconUrl: 'https://www.example.com/like.png',
///   iconTint: Colors.red,
///   background: Colors.white,
///   cornerRadius: 10.0,
///   titleStyle: TextStyle(
///     fontSize: 16.0,
///     fontWeight: FontWeight.bold,
///     color: Colors.black,
///   ),
///   onItemClick: () {
///     print('Like button clicked!');
///   },
/// );
///
/// ```
class ActionItem {
  ///[id] is an unique id for this action item
  final String id;

  ///[title] is the name for this action item
  final String title;

  ///[iconUrl] is the path to the icon image for this action item
  final String? iconUrl;

  ///[iconUrlPackageName] is the name of the package where the icon for this action item is located
  final String? iconUrlPackageName;

  ///[iconTint] is the color of the icon
  final Color? iconTint;

  ///[titleStyle] is the styling provided to the name of this action item
  final TextStyle? titleStyle;

  ///[iconBackground] is the background color of the icon
  final Color? iconBackground;

  ///[iconCornerRadius] is the corner radius of the icon
  final double? iconCornerRadius;

  ///[background] is the background color of the action item
  final Color? background;

  ///[cornerRadius] is the corner radius of the action item
  final double? cornerRadius;

  //final Function()? actionCallBack; //Change to onItemClick

  ///[onItemClick] is the callback function when this action item is selected
  final dynamic onItemClick;

  ///[ActionItem] constructor requires [id] and [title] while initializing.
  const ActionItem(
      {required this.id,
      required this.title,
      this.iconUrl,
      this.iconUrlPackageName,
      this.iconTint,
      this.iconBackground,
      this.iconCornerRadius,
      this.background,
      this.cornerRadius,
      // this.actionCallBack,
      this.titleStyle,
      this.onItemClick});

  @override
  String toString() {
    return 'ActionItem{id: $id, title: $title, titleStyle: $titleStyle,iconUrl: $iconUrl, iconTint: $iconTint, iconBackground: $iconBackground, iconCornerRadius: $iconCornerRadius, background: $background, cornerRadius: $cornerRadius, }';
  }
}
