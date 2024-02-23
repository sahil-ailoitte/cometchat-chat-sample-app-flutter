import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart'
    as kit;
import 'package:get/get_state_manager/get_state_manager.dart';

// ignore: must_be_immutable
///[CometChatOutgoingCall] is a widget which is used to show outgoing call screen.
///when the logged-in user calls another user
///
/// ```dart
/// CometChatOutgoingCall(
/// user: user,
/// theme: cometChatTheme,
/// declineButtonText: 'Decline',
/// declineButtonIconUrl: '',
/// declineButtonIconUrlPackage: '',
/// cardStyle: CardStyle(
/// width: MediaQuery.of(context).size.width,
/// height: MediaQuery.of(context).size.height,
/// background: Colors.white,
/// borderRadius: BorderRadius.all(Radius.circular(0))),
/// );
/// ```
///
//ignore: must_be_immutable
class CometChatOutgoingCall extends StatelessWidget {
  ///[theme] is used to set a custom theme for the widget.
  final CometChatTheme? theme;

  ///[user] is used to define the user for which this widget is rendered and call is initiated.
  final User? user;

  ///[subtitle] is used to define the subtitle for the widget.
  final String? subtitle;

  ///[declineButtonText] is used to define the decline button text for the widget.
  final String? declineButtonText;

  ///[declineButtonIconUrl] is used to define the decline button icon url for the widget.
  final String? declineButtonIconUrl;

  ///[declineButtonIconUrlPackage] is used to define the decline button icon url package for the widget.
  final String? declineButtonIconUrlPackage;

  ///[cardStyle] is used to define the card style for the widget.
  final CardStyle? cardStyle;

  ///[buttonStyle] is used to define the button style for the widget.
  final kit.ButtonStyle? buttonStyle;

  ///[outgoingCallStyle] is used to set a custom outgoing call style
  final OutgoingCallStyle? outgoingCallStyle;

  ///[avatarStyle] is used to set a custom avatar style
  final AvatarStyle? avatarStyle;

  final CometChatOutgoingCallController _outgoingCallController;

  ///[CometChatOutgoingCall] constructor requires [theme], [call], [user], [onError], [onDeclineCallTap], [disableSoundForCalls], [subtitle], [customSoundForCalls], [button], [declineButtonText], [declineButtonStyle], [declineButtonIconUrl], [declineButtonIconUrlPackage], [cardStyle] and [buttonStyle] while initializing.
  CometChatOutgoingCall(
      {Key? key,
      this.theme,
      required Call call,
      this.user,
      OnError? onError,
      Function(BuildContext, Call call)? onDecline,
      this.subtitle,
      bool? disableSoundForCalls,
      String? customSoundForCalls,
      String? customSoundForCallsPackage,
      this.declineButtonText,
      this.declineButtonIconUrl,
      this.declineButtonIconUrlPackage,
      this.cardStyle,
      this.buttonStyle,
      this.outgoingCallStyle,
        this.avatarStyle,
        OngoingCallConfiguration? ongoingCallConfiguration,
      })
      : _outgoingCallController = CometChatOutgoingCallController(
            activeCall: call,
            theme: theme,
            disableSoundForCalls: disableSoundForCalls,
            customSoundForCalls: customSoundForCalls,
            customSoundForCallsPackage: customSoundForCallsPackage,
            onError: onError,
            onDeclineCallTap: onDecline,
            ongoingCallConfiguration: ongoingCallConfiguration
  ),
        super(key: key) {
    _theme = theme ?? cometChatTheme;
  }

  late CometChatTheme _theme;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pop Screen Disabled. Tap on cancel call button'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
      child: Scaffold(
          body: Container(
            height: outgoingCallStyle?.height ?? double.infinity,
            width: outgoingCallStyle?.width ?? double.infinity,
            decoration: BoxDecoration(
              gradient: outgoingCallStyle?.gradient,
              color: outgoingCallStyle?.background ??  _theme.palette.getBackground() ,
              border: outgoingCallStyle?.border,
              borderRadius: BorderRadius.circular(outgoingCallStyle?.borderRadius ?? 0),
            ),
        child: GetBuilder(
          init: _outgoingCallController,
          global: false,
          dispose: (GetBuilderState<CometChatOutgoingCallController> state) =>
              state.controller?.onClose(),
          builder: (CometChatOutgoingCallController viewModel) {
            viewModel.context = context;
            return CometChatCard(
              title: user?.name,
              avatarName: user?.name,
              avatarUrl: user?.avatar,
              avatarStyle: avatarStyle,
              subtitle: subtitle ?? Translations.of(context).calling.toLowerCase(),
              cardStyle: CardStyle(
                background: cardStyle?.background,
                border: cardStyle?.border,
                gradient: cardStyle?.gradient,
                borderRadius: cardStyle?.borderRadius,
                height: cardStyle?.height,
                width: cardStyle?.width,
                titleStyle: cardStyle?.titleStyle ??
                    TextStyle(
                      color: _theme.palette.getAccent(),
                        fontSize: 28,
                        fontWeight: _theme.typography.heading.fontWeight),
                subtitleStyle: cardStyle?.subtitleStyle ??
                    TextStyle(
                        fontSize: _theme.typography.subtitle1.fontSize,
                        fontWeight: _theme.typography.subtitle1.fontWeight,
                        color: _theme.palette.getAccent600()),
              ),
              bottomView: CometChatButton(
                iconUrl: declineButtonIconUrl ?? AssetConstants.close,
                iconPackage:
                    declineButtonIconUrlPackage ?? UIConstants.packageName,
                onTap: viewModel.rejectCall,
                text: declineButtonText ??
                    Translations.of(context).cancel.toLowerCase(),
                hoverText: Translations.of(context).cancel,
                buttonStyle: kit.ButtonStyle(
                    background: buttonStyle?.background ??
                        _theme.palette.getError(),
                    iconTint:
                        buttonStyle?.iconTint ?? _theme.palette.backGroundColor.light,
                    iconBorder: buttonStyle?.iconBorder,
                    iconBorderRadius: buttonStyle?.iconBorderRadius,
                    iconBackground: buttonStyle?.iconBackground ?? Colors.transparent,
                    height: buttonStyle?.height ?? 48,
                    width: buttonStyle?.width ?? 48,
                    iconHeight: buttonStyle?.iconHeight ?? 24,
                    iconWidth: buttonStyle?.iconWidth ?? 24,
                    border: buttonStyle?.border,
                    gradient: buttonStyle?.gradient,
                    borderRadius: buttonStyle?.borderRadius,
                    textStyle: outgoingCallStyle?.declineButtonTextStyle ?? buttonStyle?.textStyle ??
                        TextStyle(
                            fontSize: _theme.typography.caption1.fontSize,
                            fontWeight: _theme.typography.subtitle2.fontWeight,
                            color: _theme.palette.getAccent600())),
              ),
            );
          },
        ),
      )),
    );
  }
}
