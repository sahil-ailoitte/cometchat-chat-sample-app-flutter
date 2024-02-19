import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class TimeSlotSelectorStyle extends BaseStyles{
  TimeSlotSelectorStyle(
      {this.titleStyle,
      this.slotTextStyle,
      this.slotBackgroundColor,
      this.selectedSlotBackgroundColor,
      this.selectedSlotTextStyle,
        double? width,
        double? height,
        Color? background,
        BoxBorder? border,
        double? borderRadius,
        Gradient? gradient,
      }) : super(
      width: width,
      height: height,
      background: background,
      border: border,
      borderRadius: borderRadius,
      gradient: gradient);

  ///[titleStyle]  sets style to the title
  final TextStyle? titleStyle;

  ///[slotTextStyle] sets style to the default slot text
  final TextStyle? slotTextStyle;

  ///[slotBackgroundColor] sets background color to the default slot
  final Color? slotBackgroundColor;

  ///[selectedSlotBackgroundColor] sets background color to the selected slot
  final Color?  selectedSlotBackgroundColor;

  ///[selectedSlotTextStyle] sets style to the selected slot text
  final TextStyle?  selectedSlotTextStyle;
}