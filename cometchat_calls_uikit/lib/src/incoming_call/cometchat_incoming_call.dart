import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart'
    as kit;
import 'package:get/get_state_manager/src/simple/get_state.dart';

///[CometChatIncomingCall] is a widget which is used to display incoming call.
///when the logged in user receives a call, this widget will be invoked.
///
/// ```dart
/// CometChatIncomingCall(
/// user: user,
/// subtitle: 'Incoming Call',
/// declineButtonText: 'Decline',
/// declineButtonTextStyle: TextStyle(color: Colors.white),
/// declineButtonIconUrl: 'assets/images/decline.png',
/// declineButtonIconUrlPackage: 'assets',
/// acceptButtonText: 'Accept',
/// acceptButtonTextStyle: TextStyle(color: Colors.white),
/// acceptButtonIconUrl: 'assets/images/accept.png',
/// acceptButtonIconUrlPackage: 'assets',
/// );
/// ```
///
//ignore: must_be_immutable
class CometChatIncomingCall extends StatelessWidget {
  ///[theme] is used to set a custom theme for the widget
  final CometChatTheme? theme;

  ///[user] is used to set a custom user for the widget
  final User? user;

  ///[subtitle] is used to set a custom subtitle for the widget
  final String? subtitle;

  ///[declineButtonText] is used to set a custom decline button text
  final String? declineButtonText;

  ///[declineButtonIconUrl] is used to set a custom decline button icon url
  final String? declineButtonIconUrl;

  ///[declineButtonIconUrlPackage] is used to set a custom decline button icon url package
  final String? declineButtonIconUrlPackage;

  ///[cardStyle] is used to set a custom card style
  final CardStyle? cardStyle;

  ///[declineButtonStyle] is used to set a custom decline button style
  final kit.ButtonStyle? declineButtonStyle;

  ///[acceptButtonText] is used to set a custom accept button text
  final String? acceptButtonText;

  ///[acceptButtonIconUrl] is used to set a custom accept button icon url
  final String? acceptButtonIconUrl;

  ///[acceptButtonIconUrlPackage] is used to set a custom accept button icon url package
  final String? acceptButtonIconUrlPackage;

  ///[acceptButtonStyle] is used to set a custom accept button style
  final kit.ButtonStyle? acceptButtonStyle;

  ///[incomingCallStyle] is used to set a custom incoming call style
  final IncomingCallStyle? incomingCallStyle;

  ///[_incomingCallController] contains view model for [CometChatIncomingCall] widget
  final CometChatIncomingCallController _incomingCallController;

  ///[avatarStyle] is used to set a custom avatar style
  final AvatarStyle? avatarStyle;

  ///[CometChatIncomingCall] constructor requires [theme], [call], [user], [onError], [onDecline], [onAccept], [disableSoundForCalls], [subtitleStyle], [subtitle], [customSoundForCalls], [button], [declineButtonText], [declineButtonStyle], [declineButtonIconUrl], [declineButtonIconUrlPackage], [cardStyle], [declineButtonTextStyle], [acceptButtonIconUrl], [acceptButtonIconUrlPackage], [acceptButtonStyle], [acceptButtonText] and [acceptButtonTextStyle] while initializing.
   CometChatIncomingCall(
      {Key? key,
      this.theme,
      required Call call,
      this.user,
      OnError? onError,
      this.subtitle,
      Function(BuildContext,Call)? onDecline,
      this.declineButtonText,
      this.declineButtonStyle,
      this.declineButtonIconUrl,
      this.declineButtonIconUrlPackage,
      this.cardStyle,
      Function(BuildContext,Call)? onAccept,
      this.acceptButtonIconUrl,
      this.acceptButtonIconUrlPackage,
      this.acceptButtonStyle,
      this.acceptButtonText,
        bool? disableSoundForCalls,
        String? customSoundForCalls,
        String? customSoundForCallsPackage,
        this.incomingCallStyle,
        this.avatarStyle,
        OngoingCallConfiguration? ongoingCallConfiguration,
      })
      : _incomingCallController = CometChatIncomingCallController(
            onAccept: onAccept,
            onDecline: onDecline,
            activeCall: call,
            onError: onError,
            disableSoundForCalls: disableSoundForCalls,
            customSoundForCalls: customSoundForCalls,
            customSoundForCallsPackage: customSoundForCallsPackage,
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
          height: incomingCallStyle?.height ?? double.infinity,
          width: incomingCallStyle?.width ?? double.infinity,
          decoration: BoxDecoration(
            gradient: incomingCallStyle?.gradient,
            color: incomingCallStyle?.background ??  _theme.palette.getBackground(),
            border: incomingCallStyle?.border,
            borderRadius: BorderRadius.circular(incomingCallStyle?.borderRadius ?? 0),
                ),
          alignment: Alignment.center,
          child: GetBuilder(
              init: _incomingCallController,
              global: false,
              dispose: (GetBuilderState<CometChatIncomingCallController> state) =>
                  state.controller?.onClose(),
              builder: (CometChatIncomingCallController viewModel) {
                viewModel.context = context;
                return CometChatCard(
                    title: user?.name,
                    avatarName: user?.name,
                    avatarUrl: user?.avatar,
                    avatarStyle: avatarStyle,
                    subtitle: subtitle ?? viewModel.getSubtitle(context),
                    cardStyle: CardStyle(
                      background: cardStyle?.background,
                      border: cardStyle?.border,
                      gradient: cardStyle?.gradient,
                      borderRadius: cardStyle?.borderRadius,
                      height: cardStyle?.height,
                      width: cardStyle?.width,
                      titleStyle: cardStyle?.titleStyle ??
                          TextStyle(
                            color:  _theme.palette.getAccent(),
                              fontSize: 28,
                              fontWeight: _theme.typography.heading.fontWeight),
                      subtitleStyle: cardStyle?.subtitleStyle ??
                          TextStyle(
                              fontSize: _theme.typography.subtitle1.fontSize,
                              fontWeight:
                                  _theme.typography.subtitle1.fontWeight,
                              color: _theme.palette.getAccent600()),
                    ),
                    bottomView: Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CometChatButton(
                          iconUrl: declineButtonIconUrl ?? AssetConstants.close,
                          iconPackage: declineButtonIconUrlPackage ??
                              UIConstants.packageName,
                          onTap: viewModel.rejectCall,
                          text: declineButtonText ??
                              Translations.of(context).cancel.toLowerCase(),
                          hoverText: Translations.of(context).cancel,
                          buttonStyle: kit.ButtonStyle(
                              background:
                                  declineButtonStyle?.background ??
                                      _theme.palette.getError(),
                              iconTint: declineButtonStyle?.iconTint ?? _theme.palette.backGroundColor.light,
                              iconBorder: declineButtonStyle?.iconBorder,
                              iconBorderRadius:
                                  declineButtonStyle?.iconBorderRadius,
                              iconBackground: declineButtonStyle?.iconBackground ?? Colors.transparent,
                              height: declineButtonStyle?.height ?? 48,
                              width: declineButtonStyle?.width ?? 48,
                              iconHeight: declineButtonStyle?.iconHeight ?? 24,
                              iconWidth: declineButtonStyle?.iconWidth ?? 24,
                              borderRadius: declineButtonStyle?.borderRadius,
                              gradient: declineButtonStyle?.gradient,
                              border: declineButtonStyle?.border,
                              textStyle: incomingCallStyle?.declineButtonTextStyle ?? declineButtonStyle?.textStyle ??
                                  TextStyle(
                                      fontSize:
                                          _theme.typography.caption1.fontSize,
                                      fontWeight: _theme
                                          .typography.subtitle2.fontWeight,
                                      color: _theme.palette.getAccent600())),
                        ),
                        CometChatButton(
                          iconUrl:
                              acceptButtonIconUrl ?? AssetConstants.audioCall,
                          iconPackage: acceptButtonIconUrlPackage ??
                              UIConstants.packageName,
                          onTap: viewModel.acceptCall,
                          text: acceptButtonText ??
                              Translations.of(context).accept.toLowerCase(),
                          hoverText: acceptButtonText ??
                              Translations.of(context).accept,
                          buttonStyle: kit.ButtonStyle(
                              iconBackground: acceptButtonStyle?.iconBackground ?? Colors.transparent,
                              background:
                                  acceptButtonStyle?.background ??
                                      _theme.palette.getPrimary(),
                              iconTint: acceptButtonStyle?.iconTint  ?? _theme.palette.backGroundColor.light,
                              iconBorder: acceptButtonStyle?.iconBorder,
                              iconBorderRadius:
                                  acceptButtonStyle?.iconBorderRadius,
                              height: acceptButtonStyle?.height ?? 48,
                              width: acceptButtonStyle?.width ?? 48,
                              iconHeight: acceptButtonStyle?.iconHeight ?? 24,
                              iconWidth: acceptButtonStyle?.iconWidth ?? 24,
                              border: acceptButtonStyle?.border,
                              gradient: acceptButtonStyle?.gradient,
                              borderRadius: acceptButtonStyle?.borderRadius,
                              textStyle: incomingCallStyle?.acceptButtonTextStyle ?? acceptButtonStyle?.textStyle ??
                                  TextStyle(
                                      fontSize:
                                          _theme.typography.caption1.fontSize,
                                      fontWeight: _theme
                                          .typography.subtitle2.fontWeight,
                                      color: _theme.palette.getAccent600())),
                        ),
                      ],
                    ));
              }),
        ),
      ),
    );
  }
}
