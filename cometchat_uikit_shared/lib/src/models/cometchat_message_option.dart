import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///Model class for message options
///
///```dart
/// CometChatMessageOption(
///  id: 'id',
///  title: 'title',
///  icon: 'assets url',
///  packageName: 'assets package name'
///  onClick: (BaseMessage baseMessage,
///      CometChatMessageListController state) {}
///  )
/// ```

class CometChatMessageOption {
  ///[CometChatMessageOption] constructor requires [id] and [title] while initializing.
  CometChatMessageOption(
      {required this.id,
      required this.title,
      this.icon,
      this.onClick,
      this.packageName,
      this.iconTint,
      this.titleStyle});

  ///[id] of the option
  String id;

  ///[title] of the option
  String title;

  ///[icon] of the option
  String? icon;

  ///[packageName] of the option
  String? packageName;

  ///[iconTint] of the option
  Color? iconTint;

  ///[titleStyle] of the option
  TextStyle? titleStyle;

  ///[backgroundColor] of the option
  Color? backgroundColor;

  ///[onClick] of the option
  Function(BaseMessage message, CometChatMessageListControllerProtocol state)?
      onClick; //Change to onItemClick

  ///[toActionItem] converts [CometChatMessageOption] to [ActionItem]
  ActionItem toActionItem() {
    return ActionItem(
        id: id,
        title: title,
        iconUrl: icon,
        onItemClick: onClick,
        iconUrlPackageName: packageName,
        iconTint: iconTint,
        background: backgroundColor,
        titleStyle: titleStyle);
  }

  ///[toActionItemFromFunction] takes a function as parameter and converts [CometChatMessageOption] to [ActionItem] with the function [onClick] as onItemClick
  ActionItem toActionItemFromFunction(
    Function(BaseMessage message, CometChatMessageListControllerProtocol state)?
        passedFunction,
  ) {
    return ActionItem(
        id: id,
        title: title,
        iconUrl: icon,
        onItemClick: passedFunction,
        iconTint: iconTint,
        titleStyle: titleStyle,
        iconUrlPackageName: packageName,
        background: backgroundColor);
  }
}
