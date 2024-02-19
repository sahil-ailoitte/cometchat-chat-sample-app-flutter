
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[MediaRecorderStyle] is a model class for customizing the styles of [CometChatMediaRecorder] widget.
///
/// ```dart
/// MediaRecorderStyle(
///  pauseIconTint: Colors.blue,
///  playIconTint: Colors.green,
///  closeIconTint: Colors.red,
///  timerTextStyle: TextStyle(),
///  submitIconTint: Colors.blue,
///  startIconTint: Colors.green,
///  stopIconTint: Colors.red,
///  audioBarTint: Colors.blue,
///  width: MediaQuery.of(context).size.width,
///  height: 150,
///  background: Colors.white,
///  border: Border.all(),
///  borderRadius: BorderRadius.circular(20),
///  gradient: LinearGradient(),
///  );
///  ```
///
class MediaRecorderStyle extends BaseStyles {
  MediaRecorderStyle(
      {this.pauseIconTint,
        this.playIconTint,
        this.closeIconTint,
        this.timerTextStyle,
        this.submitIconTint,
        this.startIconTint,
        this.stopIconTint,
        this.audioBarTint,
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

  ///[pauseIconTint] provides color to the pause Icon/widget
  final Color? pauseIconTint;

  ///[playIconTint] provides color to the play Icon/widget
  final Color? playIconTint;

  ///[closeIconTint] provides color to the close Icon/widget
  final Color? closeIconTint;

  ///[timerTextStyle] provides font to the timer text
  final TextStyle? timerTextStyle;

  ///[submitIconTint] provides color to the submit Icon/widget
  final Color? submitIconTint;

  ///[startIconTint] provides color to the start Icon/widget
  final Color? startIconTint;

  ///[stopIconTint] provides color to the stop Icon/widget
  final Color? stopIconTint;

  ///[audioBarTint] provides color to the audio bar
  final Color? audioBarTint;
}