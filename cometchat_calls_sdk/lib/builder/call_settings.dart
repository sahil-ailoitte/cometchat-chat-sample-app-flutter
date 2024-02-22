import '../interface/cometchat_calls_events_listener.dart';
import '../model/main_video_container_settings.dart';

class CallSettings{
  bool? defaultLayout;
  bool? isAudioOnly;
  bool? isSingleMode;
  bool? showSwitchToVideoCall;
  bool? enableVideoTileClick;
  bool? enableDraggableVideoTile;
  bool? endCallButtonDisable;
  bool? showRecordingButton;
  bool? startRecordingOnCallStart;
  bool? switchCameraButtonDisable;
  bool? muteAudioButtonDisable;
  bool? pauseVideoButtonDisable;
  bool? audioModeButtonDisable;
  bool? startAudioMuted;
  bool? startVideoMuted;
  String? avatarMode;
  String? mode;
  String? defaultAudioMode;
  MainVideoContainerSetting? videoSettings;
  CometChatCallsEventsListener? listener;

  CallSettings._builder(CallSettingsBuilder builder):
      defaultLayout = builder.enableDefaultLayout ,
      isAudioOnly = builder.setAudioOnlyCall,
      isSingleMode = builder.setSingleMode,
      showSwitchToVideoCall = builder.showSwitchToVideoCallButton,
      enableVideoTileClick = builder.enableVideoTileClick,
      enableDraggableVideoTile = builder.enableVideoTileDrag ,
      endCallButtonDisable = builder.showEndCallButton ,
      showRecordingButton = builder.showCallRecordButton ,
      startRecordingOnCallStart = builder.startRecordingOnCallStart ,
      switchCameraButtonDisable = builder.showSwitchCameraButton ,
      muteAudioButtonDisable = builder.showMuteAudioButton ,
      pauseVideoButtonDisable = builder.showPauseVideoButton ,
      audioModeButtonDisable = builder.showAudioModeButton ,
      startAudioMuted = builder.startWithAudioMuted,
      startVideoMuted = builder.startWithVideoMuted,
      avatarMode = builder.setAvatarMode,
      mode = builder.setMode,
      defaultAudioMode = builder.setDefaultAudioMode,
      videoSettings = builder.setMainVideoContainerSetting,
      listener = builder.listener;
}

class CallSettingsBuilder {
  bool? enableDefaultLayout;
  bool? setAudioOnlyCall;
  bool? setSingleMode;
  bool? showSwitchToVideoCallButton;
  bool? enableVideoTileClick;
  bool? enableVideoTileDrag;
  bool? showEndCallButton;
  bool? showCallRecordButton;
  bool? startRecordingOnCallStart;
  bool? showSwitchCameraButton;
  bool? showMuteAudioButton;
  bool? showPauseVideoButton;
  bool? showAudioModeButton;
  bool? startWithAudioMuted;
  bool? startWithVideoMuted;
  String? setAvatarMode;
  String? setMode;
  String? setDefaultAudioMode;
  MainVideoContainerSetting? setMainVideoContainerSetting;
  CometChatCallsEventsListener? listener;

  CallSettingsBuilder();

  CallSettings build() {
    return CallSettings._builder(this);
  }
}