import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CometChatDeleteMessageBubble] is a widget that provides a placeholder for messages thave been deleted
///
///a [BaseMessage] is considered deleted if the value of its [deletedAt] property is not null
/// ```dart
/// CometChatDeleteMessageBubble()
/// ```
class CometChatDeleteMessageBubble extends StatelessWidget {
  const CometChatDeleteMessageBubble(
      {Key? key, this.style = const DeletedBubbleStyle()})
      : super(key: key);

  ///[style] contains properties that affects the appearance of this widget
  final DeletedBubbleStyle style;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(8),
      color: style.borderColor ?? const Color(0xff141414).withOpacity(0.16),
      strokeWidth: 1,
      child: Container(
        height: style.height ?? 36,
        width: style.width ?? 164,
        decoration: BoxDecoration(
            border: style.border,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 0),
            color: style.gradient == null
                ? style.background ?? const Color(0xff3399FF).withOpacity(0)
                : null,
            gradient: style.gradient),
        alignment: Alignment.center,
        child: Text(
          Translations.of(context).message_is_deleted,
          style: style.textStyle ??
              TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff141414).withOpacity(0.4)),
        ),
      ),
    );
  }
}
