import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

///[CometChatCallLogDetailsTemplate] is the section of options displayed in [CometChatCallLogDetails]
///
/// ```dart
///
/// CometChatCallLogDetailsTemplate(
///   id: "details",
///   options: (callLog, context, theme) {
///     return [
///       CometChatCallLogDetailsOption(
///         id: "participant",
///         title: "Name",
///         customView: Text(user?.name ?? ""),
///       ),
///       CometChatCallLogDetailsOption(
///         id: "recording",
///         title: "Username",
///         customView: Text(user?.name ?? ""),
///       ),
///     ];
///   },
///   title: "Call Log Detail",
///   titleStyle: TextStyle(
///     fontSize: 18,
///     fontWeight: FontWeight.bold,
///   ),
///   sectionSeparatorColor: Colors.grey[300],
///   hideSectionSeparator: false,
///   itemSeparatorColor: Colors.grey[200],
///   hideItemSeparator: false,
/// )
///
/// ```
class CometChatCallLogDetailsTemplate {
  ///[id] is unique identifier for every [CometChatCallLogDetailsTemplate]
  final String id;

  ///[options] is a function which returns list of [CometChatCallLogDetailsOption] for every [CometChatCallLogDetailsTemplate]
  final List<CometChatCallLogDetailsOption> Function(
      CallLog? callLog, BuildContext? context, CometChatTheme? theme)? options;

  ///[title] is the title of [CometChatCallLogDetailsTemplate]
  final String? title;

  ///[titleStyle] is the style of [title] of [CometChatCallLogDetailsTemplate]
  final TextStyle? titleStyle;

  ///[sectionSeparatorColor] is the color of section separator
  final Color? sectionSeparatorColor;

  ///[hideSectionSeparator] is a boolean which decides whether to hide section separator or not
  final bool? hideSectionSeparator;

  ///[itemSeparatorColor] is the color of item separator
  final Color? itemSeparatorColor;

  ///[hideItemSeparator] is a boolean which decides whether to hide item separator or not
  final bool? hideItemSeparator;

  ///[CometChatCallLogDetailsTemplate] constructor requires [id] and [options] while initializing.
  const CometChatCallLogDetailsTemplate(
      {required this.id,
      this.options,
      this.title,
      this.titleStyle,
      this.sectionSeparatorColor,
      this.hideSectionSeparator,
      this.itemSeparatorColor,
      this.hideItemSeparator});

  @override
  String toString() {
    return 'CometChatCallDetailTemplate{id: $id, options: $options, title: $title, titleStyle: $titleStyle, sectionSeparatorColor: $sectionSeparatorColor, hideSectionSeparator: $hideSectionSeparator, itemSeparatorColor: $itemSeparatorColor, hideItemSeparator: $hideItemSeparator}';
  }
}
