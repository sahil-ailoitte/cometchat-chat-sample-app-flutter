import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CometChatMessageComposerAction] is the type of menu items allowed to be displayed [CometChatMessageComposer]
///
/// ```dart
///
/// final CometChatMessageComposerAction exampleMessageComposerAction = CometChatMessageComposerAction(
///   id: "example",
///   title: "Example Action",
///   iconUrl: "https://example.com/icon.png",
///   iconUrlPackageName: "com.example",
///   iconTint: Colors.blue,
///   titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
///   iconBackground: Colors.grey,
///   iconCornerRadius: 8,
///   background: Colors.white,
///   cornerRadius: 8,
///   onItemClick: () {
///     // Do something when this message composer action is selected
///   },
/// );
///
/// ```
class CometChatMessageComposerAction {
  ///[CometChatMessageComposerAction] constructor requires [id] and [title] while initializing.
  const CometChatMessageComposerAction(
      {required this.id,
      required this.title,
      this.iconUrl,
      this.iconUrlPackageName,
      this.iconTint,
      this.iconBackground,
      this.iconCornerRadius,
      this.background,
      this.cornerRadius,
      this.titleStyle,
      this.onItemClick});

  ///[id] is an unique id for this message composer action
  final String id;

  ///[title] is the name for this message composer action
  final String title;

  ///[iconUrl] is the path to the icon image for this message composer action
  final String? iconUrl;

  ///[iconUrlPackageName] is the name of the package where the icon for this message composer action is located
  final String? iconUrlPackageName;

  ///[iconTint] is the color of the icon
  final Color? iconTint;

  ///[titleStyle] is the styling provided to the name of this message composer action
  final TextStyle? titleStyle;

  ///[iconBackground] is the background color of the icon
  final Color? iconBackground;

  ///[iconCornerRadius] is the border radius the icon
  final double? iconCornerRadius;

  ///[background] is the background color for this message composer action
  final Color? background;

  ///[cornerRadius] is the border radius for this message composer action
  final double? cornerRadius;

  ///[onItemClick] executes some task when this message composer action is selected
  final Function(BuildContext, User?, Group?)? onItemClick;

  @override
  String toString() {
    return 'CometChatMessageComposerOption{id: $id, title: $title, titleStyle: $titleStyle,iconUrl: $iconUrl, iconTint: $iconTint, iconBackground: $iconBackground, iconCornerRadius: $iconCornerRadius, background: $background, cornerRadius: $cornerRadius, }';
  }
}
