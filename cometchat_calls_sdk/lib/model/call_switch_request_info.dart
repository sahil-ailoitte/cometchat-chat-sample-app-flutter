import 'rtc_user.dart';

class CallSwitchRequestInfo{
  String? sessionId;
  RTCUser? requestInitiatedBy;
  RTCUser? requestAcceptedBy;

  CallSwitchRequestInfo({this.sessionId, this.requestInitiatedBy,this.requestAcceptedBy});

  String? getSessionId() {
    return sessionId;
  }

  RTCUser? getRequestInitiatedBy() {
    return requestInitiatedBy;
  }

  void setRequestInitiatedBy(RTCUser user) {
    requestInitiatedBy = user;
  }

  RTCUser? getRequestAcceptedBy() {
    return requestAcceptedBy;
  }

  void setRequestAcceptedBy(RTCUser user) {
    requestInitiatedBy = user;
  }

  factory CallSwitchRequestInfo.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of action map is null');
    return CallSwitchRequestInfo(
      sessionId: map['sessionId'] ?? '',
      requestInitiatedBy: map['requestInitiatedBy'] == null ? null : RTCUser.fromMap(map['requestInitiatedBy']!),
      requestAcceptedBy: map['requestAcceptedBy'] == null ? null : RTCUser.fromMap(map['requestAcceptedBy']!),
    );
  }

}