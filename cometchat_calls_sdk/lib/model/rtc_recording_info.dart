import 'rtc_user.dart';

class RTCRecordingInfo {
  bool? recordingStarted;
  RTCUser? user;

  RTCRecordingInfo({this.recordingStarted, this.user});

  bool? getRecordingStarted() {
    return recordingStarted;
  }

  void setRecordingStarted(bool recordingStarted) {
    this.recordingStarted = recordingStarted;
  }

  RTCUser? getUser() {
    return user;
  }

  void detUser(RTCUser user) {
    this.user = user;
  }

  factory RTCRecordingInfo.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of action map is null');
    return RTCRecordingInfo(
      recordingStarted: map['recordingStarted'],
      user: map['user'] == null ? null : RTCUser.fromMap(map['user']!)
    );
  }

}
