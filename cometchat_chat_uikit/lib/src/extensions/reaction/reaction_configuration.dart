import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

///[ReactionConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [ReactionExtension]
/// ```dart
/// ReactionConfiguration reactionConfig = ReactionConfiguration(
///     optionTitle: 'Like',
///     optionIconUrl: 'assets/icons/like.png',
///     optionIconUrlPackageName: 'my_package',
///     optionStyle: ReactionOptionStyle(
///         iconTint: Colors.blue,
///     ),
///     theme: CometChatTheme(),
///     addReactionIcon: Icon(Icons.add),
///     reactionsStyle: ReactionsStyle(
///         emojiBorderRadius: 30,
///     ),
///     emojiKeyboardStyle: ReactionsEmojiKeyboardStyle(
///         backgroundColor: Colors.white,
///         selectedCategoryIconColor: Colors.black,
///         dividerColor: Colors.grey,
///         unselectedCategoryIconColor: Colors.grey[200],
///     ),
/// );
///
/// ```
class ReactionConfiguration {
  ReactionConfiguration(
      {this.optionTitle,
      this.optionIconUrl,
      this.optionIconUrlPackageName,
      this.optionStyle,
      this.theme,
      this.addReactionIcon,
      this.reactionsStyle,
      this.emojiKeyboardStyle});

  ///[theme] sets custom theme
  final CometChatTheme? theme;

  ///[addReactionIcon] add reaction icon
  final Widget? addReactionIcon;

  ///[reactionsStyle] provides style to the emoji keyboard and the emoji
  final ReactionsStyle? reactionsStyle;

  ///[optionTitle] is the name for the option for this extension
  final String? optionTitle;

  ///[optionIconUrl] is the path to the icon image for the option for this extension
  final String? optionIconUrl;

  ///[optionIconUrlPackageName] is the name of the package where the icon for the option for this extension is located
  final String? optionIconUrlPackageName;

  ///[optionStyle] provides style to the option
  final ReactionOptionStyle? optionStyle;

  ///[emojiKeyboardStyle] provides styling to the keyboard that contains the emojis
  final ReactionsEmojiKeyboardStyle? emojiKeyboardStyle;
}
