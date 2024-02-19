import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CallLogDetailsUtils {
  // returns default primary view
  static CometChatCallLogDetailsTemplate? getPrimaryDetailsTemplate(
      BuildContext context, User? loggedInUser,
      {CometChatTheme? theme,
      CallLogDetailsStyle? detailsStyle,
      CallButtonsConfiguration? callButtonsConfiguration,
      String? separatorDatePattern,
      String? datePattern,
      CallLog? callLog,
      OutgoingCallConfiguration? outgoingCallConfiguration}) {
    return CometChatCallLogDetailsTemplate(
      id: DetailsTemplateConstants.primaryActions,
      title: "",
      options: (callLog, context, theme) {
        return [
          CometChatCallLogDetailsOption(
            id: CallLogsConstants.primary,
            title: "",
            customView: (callLog == null || loggedInUser == null)
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (!CallLogsUtils.isUser(callLog))
                          ? const SizedBox()
                          : const SizedBox(
                              height: 20,
                            ),
                      (!CallLogsUtils.isUser(callLog))
                          ? const SizedBox()
                          : Center(
                              child: CometChatCallButtons(
                                onError: callButtonsConfiguration?.onError,
                                hideVideoCall:
                                    callButtonsConfiguration?.hideVideoCall,
                                hideVoiceCall:
                                    callButtonsConfiguration?.hideVoiceCall,
                                ongoingCallConfiguration:
                                    callButtonsConfiguration
                                        ?.ongoingCallConfiguration,
                                outgoingCallConfiguration:
                                    callButtonsConfiguration
                                        ?.outgoingCallConfiguration,
                                videoCallIconHoverText: callButtonsConfiguration
                                    ?.videoCallIconHoverText,
                                videoCallIconPackage: callButtonsConfiguration
                                    ?.videoCallIconPackage,
                                videoCallIconText: callButtonsConfiguration
                                        ?.videoCallIconText ??
                                    Translations.of(context!).video_call,
                                voiceCallIconHoverText: callButtonsConfiguration
                                    ?.voiceCallIconHoverText,
                                voiceCallIconPackage: callButtonsConfiguration
                                    ?.voiceCallIconPackage,
                                voiceCallIconText: callButtonsConfiguration
                                        ?.voiceCallIconText ??
                                    Translations.of(context!).audio_call,
                                voiceCallIconURL: callButtonsConfiguration
                                        ?.voiceCallIconURL ??
                                    AssetConstants.audioCall,
                                videoCallIconURL: callButtonsConfiguration
                                        ?.videoCallIconURL ??
                                    AssetConstants.videoCall,
                                user: User(
                                  uid: CallLogsUtils.returnReceiverId(
                                      loggedInUser, callLog),
                                  name: CallLogsUtils.receiverName(
                                      loggedInUser, callLog),
                                ),
                                onVoiceCallClick: (context, user, group) {
                                  if (callButtonsConfiguration
                                          ?.onVoiceCallClick !=
                                      null) {
                                    callButtonsConfiguration?.onVoiceCallClick!(
                                        context, user, group);
                                  } else {
                                    if (user != null) {
                                      initiateCall(
                                          context,
                                          user,
                                          callLog,
                                          loggedInUser,
                                          outgoingCallConfiguration,
                                          isAudio: true);
                                    }
                                  }
                                },
                                onVideoCallClick: (context, user, group) {
                                  if (callButtonsConfiguration
                                          ?.onVideoCallClick !=
                                      null) {
                                    callButtonsConfiguration?.onVideoCallClick!(
                                        context, user, group);
                                  } else {
                                    if (user != null) {
                                      initiateCall(
                                          context,
                                          user,
                                          callLog,
                                          loggedInUser,
                                          outgoingCallConfiguration,
                                          isAudio: false);
                                    }
                                  }
                                },
                                callButtonsStyle: callButtonsConfiguration
                                        ?.callButtonsStyle ??
                                    CallButtonsStyle(
                                      videoCallIconTint:
                                          detailsStyle?.videoCallIconTint ??
                                              theme?.palette.getPrimary(),
                                      voiceCallIconTint:
                                          detailsStyle?.voiceCallIconTint ??
                                              theme?.palette.getPrimary(),
                                      background: detailsStyle?.background ??
                                          theme?.palette.getAccent200(),
                                      height: detailsStyle?.height,
                                      width: detailsStyle?.width,
                                      borderRadius:
                                          detailsStyle?.borderRadius ?? 10,
                                      border: detailsStyle?.border,
                                      gradient: detailsStyle?.gradient,
                                    ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      CallLogsUtils.getTime(
                          theme ?? cometChatTheme,
                          detailsStyle?.separatorDateStyle,
                          context!,
                          callLog.initiatedAt,
                          datePattern: separatorDatePattern,
                          needYear: true),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CallLogsUtils.getTime(
                            theme ?? cometChatTheme,
                            detailsStyle?.timeStyle,
                            context,
                            callLog.initiatedAt,
                            datePattern: datePattern,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            CallUtils.getStatus(context, callLog, loggedInUser),
                            style: detailsStyle?.callStatusStyle ??
                                TextStyle(
                                  fontSize: theme?.typography.title2.fontSize,
                                  fontWeight:
                                      theme?.typography.heading.fontWeight,
                                  color: theme?.palette.getAccent700(),
                                ),
                          ),
                          const Spacer(),
                          Text(
                            CallLogsUtils.formatMinutesAndSeconds(
                                callLog.totalDurationInMinutes ?? 0.0),
                            style: detailsStyle?.durationStyle ??
                                TextStyle(
                                  fontSize:
                                      theme?.typography.subtitle1.fontSize,
                                  fontWeight:
                                      theme?.typography.heading.fontWeight,
                                  color: theme?.palette.getAccent600(),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          ),
        ];
      },
    );
  }

  static CometChatCallLogDetailsTemplate? getSecondaryDetailsTemplate(
      BuildContext context,
      User? loggedInUser,
      CallLog? callLog,
      CallLogDetailsStyle? detailsStyle,
      {CometChatTheme? theme,
      String? arrowIcon}) {
    if (callLog != null) {
      return CometChatCallLogDetailsTemplate(
        id: DetailsTemplateConstants.secondaryActions,
        options: (callLog, context, theme) {
          if (context == null) {
            return [];
          }
          return [
            CometChatCallLogDetailsOption(
              id: CallLogsConstants.participants,
              title: Translations.of(context).participant,
              tail: SizedBox(
                width: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        callLog?.participants?.length.toString() ?? "",
                        style: detailsStyle?.countStyle ??
                            TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: theme?.typography.subtitle1.fontSize,
                              fontWeight: theme?.typography.heading.fontWeight,
                              color: theme?.palette.getAccent600(),
                            ),
                      ),
                    ),
                    Image.asset(
                      arrowIcon ?? AssetConstants.sideArrow,
                      package: UIConstants.packageName,
                      color: detailsStyle?.arrowIconTint ??
                          theme?.palette.getAccent700(),
                    ),
                  ],
                ),
              ),
              height: 56,
            ),
            if ((callLog != null &&
                callLog.recordings != null &&
                callLog.recordings!.isNotEmpty))
              CometChatCallLogDetailsOption(
                id: CallLogsConstants.recordings,
                title: Translations.of(context).recording,
                tail: SizedBox(
                  width: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          callLog.recordings?.length.toString() ?? "",
                          style: detailsStyle?.countStyle ??
                              TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: theme?.typography.subtitle1.fontSize,
                                fontWeight:
                                    theme?.typography.heading.fontWeight,
                                color: theme?.palette.getAccent600(),
                              ),
                        ),
                      ),
                      Image.asset(
                        arrowIcon ?? AssetConstants.sideArrow,
                        package: UIConstants.packageName,
                        color: detailsStyle?.arrowIconTint ??
                            theme?.palette.getAccent700(),
                      ),
                    ],
                  ),
                ),
                height: 56,
              ),
            CometChatCallLogDetailsOption(
              id: CallLogsConstants.callHistory,
              title: Translations.of(context).call_history,
              tail: Image.asset(
                arrowIcon ?? AssetConstants.sideArrow,
                package: UIConstants.packageName,
                color: detailsStyle?.arrowIconTint ??
                    theme?.palette.getAccent700(),
              ),
              height: 56,
            ),
          ];
        },
      );
    }
    return null;
  }

  static List<CometChatCallLogDetailsTemplate> getDefaultDetailsTemplates(
      BuildContext context,
      User? loggedInUser,
      CallButtonsConfiguration? callButtonsConfiguration,
      CallLogDetailsStyle? detailsStyle,
      {CometChatTheme? theme,
      CallLog? callLog,
      String? separatorDatePattern,
      String? datePattern,
      String? arrowIcon,
      OutgoingCallConfiguration? outgoingCallConfiguration}) {
    if (callLog != null) {
      CometChatCallLogDetailsTemplate? primaryTemplate = getPrimaryDetailsTemplate(
        context,
        loggedInUser,
        callButtonsConfiguration: callButtonsConfiguration,
        detailsStyle: detailsStyle,
        theme: theme,
        separatorDatePattern: separatorDatePattern,
        datePattern: datePattern,
        callLog: callLog,
        outgoingCallConfiguration: outgoingCallConfiguration,
      );
      CometChatCallLogDetailsTemplate? secondaryTemplate =
          getSecondaryDetailsTemplate(
        context,
        loggedInUser,
        callLog,
        detailsStyle,
        arrowIcon: arrowIcon,
        theme: theme,
      );
      return [
        if (primaryTemplate != null) primaryTemplate,
        if (secondaryTemplate != null) secondaryTemplate
      ];
    } else {
      return [];
    }
  }

  // initiate Call
  static initiateCall(BuildContext context, User user, CallLog log,
      User loggedInUser, OutgoingCallConfiguration? outgoingCallConfiguration,
      {bool isAudio = true}) {
    Call call = Call(
      receiverUid: user.uid,
      type:
          (isAudio) ? CallTypeConstants.audioCall : CallTypeConstants.videoCall,
      receiverType: log.receiverType ?? "User",
      callReceiver: user,
      callInitiator: loggedInUser,
    );
    CometChatUIKitCalls.initiateCall(
      call,
      onSuccess: (call) {
        if (kDebugMode) {
          debugPrint("Call initiated Successfully");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CometChatOutgoingCall(
              call: call,
              theme: outgoingCallConfiguration?.theme,
              subtitle: outgoingCallConfiguration?.subtitle,
              buttonStyle: outgoingCallConfiguration?.buttonStyle,
              cardStyle: outgoingCallConfiguration?.cardStyle,
              declineButtonIconUrl:
                  outgoingCallConfiguration?.declineButtonIconUrl,
              declineButtonIconUrlPackage:
                  outgoingCallConfiguration?.declineButtonIconUrlPackage,
              declineButtonText: outgoingCallConfiguration?.declineButtonText,
              onDecline: outgoingCallConfiguration?.onDecline,
              disableSoundForCalls:
                  outgoingCallConfiguration?.disableSoundForCalls,
              customSoundForCalls:
                  outgoingCallConfiguration?.customSoundForCalls,
              customSoundForCallsPackage:
                  outgoingCallConfiguration?.customSoundForCallsPackage,
              onError: outgoingCallConfiguration?.onError,
              outgoingCallStyle: outgoingCallConfiguration?.outgoingCallStyle,
              avatarStyle: outgoingCallConfiguration?.avatarStyle,
              ongoingCallConfiguration:
                  outgoingCallConfiguration?.ongoingCallConfiguration,
            ),
          ),
        );
      },
      onError: (excep) {
        if (kDebugMode) {
          debugPrint(
              "Error in Call initialization ${excep.code} ${excep.details} ${excep.message}");
        }
      },
    );
  }
}
