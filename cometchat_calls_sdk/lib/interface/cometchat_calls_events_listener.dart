import '../helper/cometchatcalls_exception.dart';
import '../model/audio_mode.dart';
import '../model/call_switch_request_info.dart';
import '../model/rtc_muted_user.dart';
import '../model/rtc_recording_info.dart';
import '../model/rtc_user.dart';

abstract class CometChatCallsEventsListener{
  void onCallEnded() {}
  void onCallEndButtonPressed(){}
  void onUserJoined(RTCUser user){}
  void onUserLeft(RTCUser user){}
  void onUserListChanged(List<RTCUser> users){}
  void onAudioModeChanged(List<AudioMode> devices){}
  void onCallSwitchedToVideo(CallSwitchRequestInfo info){}
  void onUserMuted(RTCMutedUser muteObj){}
  void onRecordingToggled(RTCRecordingInfo info){}
  void onError(CometChatCallsException ce){}
}
