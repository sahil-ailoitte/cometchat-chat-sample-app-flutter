import 'package:flutter/material.dart';

import '../../../../cometchat_uikit_shared.dart';

///[CometChatMessageBubble] is a widget that provides the skeleton structure for any message bubble constructed from a [CometChatMessageTemplate] which doesnt have a [bubbleView]
///it binds together the [leadingView], [headerView], [contentView], [footerView], [bottomView], [threadView] declared in the [CometChatMessageTemplate] to collectively form a message bubble
///
/// ```dart
///   CometChatMessageBubble(
///        alignment: BubbleAlignment.center,
///        leadingView: Container(),
///        headerView: Container(),
///        contentView: Container(),
///        footerView: Container(),
///        bottomView: Container(),
///        threadView: Container(),
///        replyView: Container(),
///        style: MessageBubbleStyle(),
///      );
/// ```
class CometChatMessageBubble extends StatelessWidget {
  const CometChatMessageBubble(
      {Key? key,
      this.style = const MessageBubbleStyle(),
      this.alignment,
      this.contentView,
      this.footerView,
      this.headerView,
      this.leadingView,
      this.replyView,
      this.threadView,
      this.bottomView})
      : super(key: key);

  ///[leadingView] widget to be shown on the left side of the bubble
  final Widget? leadingView;

  ///[headerView] widget to be shown on the top of the bubble
  final Widget? headerView;

  ///[replyView] widget to be shown on the top of the bubble
  final Widget? replyView;

  ///[contentView] widget to be shown in the center of the bubble
  final Widget? contentView;

  ///[threadView] widget to be shown in the center of the bubble
  final Widget? threadView;

  ///[footerView] widget to be shown at the bottom of the bubble
  final Widget? footerView;

  ///[alignment] alignment of the bubble
  final BubbleAlignment? alignment;

  ///[style] styling for the bubble
  final MessageBubbleStyle style;

  ///[bottomView] widget to be shown at the bottom of the bubble
  final Widget? bottomView;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //color: Colors.red,
          gradient: style.gradient,
          border: style.border,
          borderRadius: BorderRadius.circular(style.borderRadius ?? 0)),
      child: Padding(
        padding: style.contentPadding ?? const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leadingView != null) leadingView!,
            Column(
              crossAxisAlignment: alignment == BubbleAlignment.right
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [headerView ?? const SizedBox()],
                ),
                //-----bubble-----
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: alignment == BubbleAlignment.right
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 3,
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: style.width ??
                                MediaQuery.of(context).size.width * (style.widthFlex?? (65 / 100))
                        ),
                        decoration: BoxDecoration(
                            color: style.background ??
                                const Color(0xffF8F8F8).withOpacity(0.92),
                            borderRadius: BorderRadius.all(
                                Radius.circular(style.borderRadius ?? 8)),
                            border: style.border,
                            gradient: style.gradient),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(style.borderRadius ?? 8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (replyView != null) replyView!,

                              if (contentView != null) contentView!,

                              if (bottomView != null) bottomView!,

                              //-----thread replies-----
                              if (threadView != null) threadView!,
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (footerView != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: footerView!,
                      )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
