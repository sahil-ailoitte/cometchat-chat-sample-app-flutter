import '../interface/cometchat_calls_events_listener.dart';

class PresentationSettings{
  bool? defaultLayout;
  bool? isAudioOnly;
  bool? isSingleMode;
  bool? endCallButtonDisable;
  bool? showRecordingButton;
  bool? switchCameraButtonDisable;
  bool? muteAudioButtonDisable;
  bool? pauseVideoButtonDisable;
  bool? audioModeButtonDisable;
  bool? startAudioMuted;
  bool? startVideoMuted;
  bool? isPresenter;
  String? defaultAudioMode;
  CometChatCallsEventsListener? listener;

  PresentationSettings._builder(PresentationSettingsBuilder builder):
      defaultLayout = builder.enableDefaultLayout ,
      isAudioOnly = builder.setAudioOnlyCall,
      isSingleMode = builder.setSingleMode,
      endCallButtonDisable = builder.showEndCallButton ,
      showRecordingButton = builder.showCallRecordButton ,
      switchCameraButtonDisable = builder.showSwitchCameraButton ,
      muteAudioButtonDisable = builder.showMuteAudioButton ,
      pauseVideoButtonDisable = builder.showPauseVideoButton ,
      audioModeButtonDisable = builder.showAudioModeButton ,
      startAudioMuted = builder.startWithAudioMuted,
      startVideoMuted = builder.startWithVideoMuted,
      defaultAudioMode = builder.setDefaultAudioMode,
      isPresenter = builder.isPresenter,
      listener = builder.listener;
}

class PresentationSettingsBuilder {
  bool? enableDefaultLayout;
  bool? setAudioOnlyCall;
  bool? setSingleMode;

  bool? showEndCallButton;
  bool? showCallRecordButton;
  bool? startRecordingOnCallStart;
  bool? showSwitchCameraButton;
  bool? showMuteAudioButton;
  bool? showPauseVideoButton;
  bool? showAudioModeButton;
  bool? startWithAudioMuted;
  bool? startWithVideoMuted;
  String? setDefaultAudioMode;
  bool? isPresenter;
  CometChatCallsEventsListener? listener;

  PresentationSettingsBuilder();

  PresentationSettings build() {
    return PresentationSettings._builder(this);
  }
}