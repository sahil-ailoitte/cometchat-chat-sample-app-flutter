import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CometChatCard] is a prebuilt widget which is used to display a card with title, subtitle, avatar and bottom view.
///
/// ```dart
/// CometChatCard(
///  title: 'Title',
///  subtitle: 'Subtitle',
///  avatar: CometChatAvatar(),
///  bottomView: Text('Bottom View'),
///  );
///  ```
///
class CometChatCard extends StatelessWidget {
  const CometChatCard(
      {Key? key,
      this.title,
      this.subtitle,
      this.avatar,
      this.cardStyle,
      this.avatarStyle,
      this.avatarName,
      this.avatarUrl,
      this.bottomView,
      })
      : super(key: key);

  ///[title] sets title for card
  final String? title;

  ///[subtitle] sets subtitle for card
  final String? subtitle;

  ///[avatar] sets avatar for card
  final CometChatAvatar? avatar;

  ///[cardStyle] sets style for card
  final CardStyle? cardStyle;

  ///[avatarStyle] sets style for avatar
  final AvatarStyle? avatarStyle;

  ///[avatarUrl] sets avatarUrl for avatar
  final String? avatarUrl;

  ///[avatarName] sets avatarName for avatar
  final String? avatarName;

  ///[bottomView] sets bottomView for card
  final Widget? bottomView;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null || subtitle != null)
          Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 2,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: cardStyle?.titleStyle,
                ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: cardStyle?.subtitleStyle,
                )
            ],
          ),
        avatar ??
            CometChatAvatar(
              image: avatarUrl,
              name: avatarName,
              style: AvatarStyle(
                  background: avatarStyle?.background,
                  height: avatarStyle?.height ?? 200, //220
                  width: avatarStyle?.width ?? 200, //220
                  gradient: avatarStyle?.gradient,
                  borderRadius: avatarStyle?.borderRadius ,
                border: avatarStyle?.border,
                nameTextStyle: avatarStyle?.nameTextStyle,
                outerBorderRadius: avatarStyle?.outerBorderRadius,
                outerViewBackgroundColor: avatarStyle?.outerViewBackgroundColor,
                outerViewBorder: avatarStyle?.outerViewBorder,
                outerViewSpacing: avatarStyle?.outerViewSpacing,
                outerViewWidth: avatarStyle?.outerViewWidth,
              ),
            ),
        if (bottomView != null) bottomView!
      ],
    );
  }
}
