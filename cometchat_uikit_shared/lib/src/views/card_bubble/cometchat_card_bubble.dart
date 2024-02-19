import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';
import '../../utils/action_element_utils.dart';

///[CometChatCardBubble] creates the card view for [InteractiveMessage] with type [MessageTypeConstants.card] by default
///
///used by default  when the category and type of [MediaMessage] is message and [MessageTypeConstants.image] respectively
/// ```dart
///             CometChatCardBubble(
///                  theme: cometChatTheme,
///                  imageUrl:
///                      'image url',
///                  style: const CardBubbleStyle(
///                    borderRadius: 8,
///                  ),
///                );
/// ```
class CometChatCardBubble extends StatefulWidget {

  const CometChatCardBubble(
      {Key? key,
      this.cardBubbleStyle,
      required this.cardMessage,
      this.theme,
      this.onActionTap,
      this.loggedInUser})
      : super(key: key);

  ///[cardBubbleStyle] sets the style for the card
  final CardBubbleStyle? cardBubbleStyle;

  ///[cardMessage] sets the message object for the card
  final CardMessage cardMessage;

  ///[theme] sets the theme for the card
  final CometChatTheme? theme;

  ///[onActionTap] overrides the on tap functionality
  final Function(BaseInteractiveElement interactiveElement)? onActionTap;

  ///[loggedInUser] pass logged in user to bubble
  final User? loggedInUser;

  @override
  State<CometChatCardBubble> createState() => _CometChatCardState();
}

class _CometChatCardState extends State<CometChatCardBubble> {
  late CometChatTheme theme;
  Map<String, bool?> interactionMap = {};
  bool isSentByMe = false;
  late ButtonElementStyle defaultButtonStyle;

  @override
  void initState() {
    theme = widget.theme ?? cometChatTheme;
    _populateMap();
    populateStyles();
    isSentByMe = InteractiveMessageUtils.checkIsSentByMe(
        widget.loggedInUser, widget.cardMessage);
    super.initState();
  }

  //populates the
  _populateMap() {
    if (widget.cardMessage.interactions != null) {
      for (var element in widget.cardMessage.interactions!) {
        interactionMap[element.elementId] = true;
      }
    }
  }

  populateStyles() {
    TextStyle defaultButtonTextStyle = TextStyle(
        fontSize: theme.typography.title2.fontSize,
        fontWeight: theme.typography.title2.fontWeight,
        fontFamily: theme.typography.title2.fontFamily,
        color: theme.palette.getPrimary());

    defaultButtonStyle = ButtonElementStyle(
      height: 35,
      borderRadius: 6,
      buttonTextStyle: defaultButtonTextStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.palette.getBackground(),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(
          color: theme.palette.getSecondary(),
          width: 4,
        ),
      ),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 65 / 100),
      //color: theme.palette.getBackground(),
      child: Column(
        children: [
          if (widget.cardMessage.imageUrl != null &&
              widget.cardMessage.imageUrl?.trim() != '')
            CometChatImageBubble(
              style: ImageBubbleStyle(
                width: MediaQuery.of(context).size.width * 65 / 100,
              ),
              theme: theme,
              imageUrl: widget.cardMessage.imageUrl!,
            ),
          if (widget.cardMessage.text.trim() != '')
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                widget.cardMessage.text,
                style: TextStyle(
                        fontWeight: theme.typography.subtitle1.fontWeight,
                        fontSize: theme.typography.subtitle1.fontSize,
                        fontFamily: theme.typography.subtitle1.fontFamily,
                        color: theme.palette.getAccent())
                    .merge(widget.cardBubbleStyle?.textStyle),
              ),
            ),
          if (widget.cardMessage.cardActions.isNotEmpty)
            ...List.generate(widget.cardMessage.cardActions.length,
                (index) => showActions(widget.cardMessage.cardActions[index])),
        ],
      ),
    );
  }

  Widget showActions(BaseInteractiveElement interactiveElement) {
    switch (interactiveElement.runtimeType) {
      case ButtonElement:
        ButtonElement buttonElement = interactiveElement as ButtonElement;

        bool isDisabled = InteractiveMessageUtils.checkElementDisabled(
            interactionMap, buttonElement, isSentByMe, widget.cardMessage);

        ButtonElementStyle buttonElementStyle;

        buttonElementStyle =
            widget.cardBubbleStyle?.buttonStyle?.merge(defaultButtonStyle) ??
                defaultButtonStyle;

        return Center(
          child: InkWell(
            onTap: () async {
              if (isDisabled) {
                return;
              }

              if (widget.onActionTap == null) {
                bool status = await ActionElementUtils.performAction(
                  element: buttonElement,
                  messageId: widget.cardMessage.id,
                  context: context,
                  theme: theme,
                );

                if (status == true) {
                  markInteracted(buttonElement);
                }
              } else {
                widget.onActionTap!(interactiveElement);
              }
            },
            child: Container(
              height: buttonElementStyle.height,
              width: buttonElementStyle.width,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: theme.palette.getSecondary(), // Border color
                  width: 4.0, // Border width
                ),
              )),
              child: Center(
                child: Text(buttonElement.buttonText,
                    style: isDisabled == true
                        ? buttonElementStyle.buttonTextStyle?.merge(
                            TextStyle(color: theme.palette.getAccent500()))
                        : buttonElementStyle.buttonTextStyle),
              ),
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  markInteracted(BaseInteractiveElement interactiveElement) async {
    await InteractiveMessageUtils.markInteracted(
        interactiveElement, widget.cardMessage, interactionMap,
        onSuccess: (bool matched) {
      if (mounted) {
        setState(() {});
      } else {}
    });
  }
}
