import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

enum ReceiptStatus { error, waiting, sent, read, delivered }

///[CometChatReceipt] is a widget that indicates the delivery status of a message
///by default, a single tick mark indicates a message has been sent
///a double tick mark indicates a message has been delivered
///a double tick mark of color [cometChatTheme.palette.primary] indicates a message has been read
/// ```dart
///
///     CometChatReceipt(
///       status: ReceiptStatus.read,
///      );
///
/// ```
class CometChatReceipt extends StatelessWidget {
  const CometChatReceipt({
    Key? key,
    this.waitIcon,
    this.sentIcon,
    this.deliveredIcon,
    this.errorIcon,
    this.readIcon,
    required this.status,
  }) : super(key: key);

  ///[waitIcon] widget visible while sentAt and deliveredAt is null in [BaseMessage]. If blank will load default waitIcon
  final Widget? waitIcon;

  ///[sentIcon] widget visible while sentAt != null and deliveredAt is null in [BaseMessage]. If blank will load default sentIcon
  final Widget? sentIcon;

  ///[deliveredIcon] widget visible while  deliveredAt != null  in [BaseMessage]. If blank will load default deliveredIcon
  final Widget? deliveredIcon;

  ///[errorIcon] widget visible while sentAt and deliveredAt is null in [BaseMessage]. If blank will load default errorIcon
  final Widget? errorIcon;

  ///[readIcon] widget visible when readAt != null in [BaseMessage]. If blank will load default readIcon
  final Widget? readIcon;

  ///receipt status from which sentAt and readAt will be read to get the receipts
  final ReceiptStatus status;

  @override
  Widget build(BuildContext context) {
    late Widget receiptWidget;
    receiptWidget = waitIcon ?? const CircularProgressIndicator();
    if (status == ReceiptStatus.error) {
      receiptWidget = const Icon(Icons.error_outline, size: 14);
    } else if (status == ReceiptStatus.read) {
      receiptWidget = readIcon ??
          Image.asset(
            AssetConstants.messageReceived,
            package: UIConstants.packageName,
            color: const Color(0xff3399FF),
          );
    } else if (status == ReceiptStatus.delivered) {
      receiptWidget = deliveredIcon ??
          Image.asset(
            AssetConstants.messageReceived,
            package: UIConstants.packageName,
          );
    } else if (status == ReceiptStatus.sent) {
      receiptWidget = sentIcon ??
          Image.asset(
            AssetConstants.messageSent,
            package: UIConstants.packageName,
          );
    } else if (status == ReceiptStatus.waiting) {
      receiptWidget = Padding(
        padding: const EdgeInsets.all(1.0),
        child: waitIcon ??
            const SizedBox(
              height: 14,
              width: 14,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ),
      );
    } else {
      receiptWidget = const SizedBox();
    }

    return receiptWidget;
  }
}
