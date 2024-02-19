import 'package:flutter/material.dart';

///[ReceiptStyle] is a data class that has styling-related properties 
///to customize the appearance of [CometChatReceipt]
class ReceiptStyle {
  ReceiptStyle({this.sentIconTint, this.deliveredIconTint, this.readIconTint});

  ///[sentIconTint] It is used to change the icon color of receipt when ReceiptStatus is sent
  final Color? sentIconTint;

  ///[deliveredIconTint] It is used to change the icon color of receipt when ReceiptStatus is delivered
  final Color? deliveredIconTint;

  ///[readIconTint] It is used to change the icon color of receipt when ReceiptStatus is read
  final Color? readIconTint;
}
