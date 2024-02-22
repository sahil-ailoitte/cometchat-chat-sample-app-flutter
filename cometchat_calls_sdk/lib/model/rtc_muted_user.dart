import 'rtc_user.dart';

class RTCMutedUser{
  RTCUser? muted;
  RTCUser? mutedBy;

  RTCMutedUser({this.muted, this.mutedBy});

  RTCUser? getMuted() {
    return muted;
  }

  void setMuted(RTCUser muted) {
    this.muted = muted;
  }

  RTCUser? getMutedBy() {
    return mutedBy;
  }

  void setMutedBy(RTCUser mutedBy) {
    this.mutedBy = mutedBy;
  }

  factory RTCMutedUser.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of action map is null');
    return RTCMutedUser(
      muted: map['muted'] == null ? null : RTCUser.fromMap(map['muted']!),
      mutedBy: map['mutedBy'] == null ? null : RTCUser.fromMap(map['mutedBy']!)
    );
  }

}