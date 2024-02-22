import 'package:cometchat_calls_sdk/cometchat_calls_sdk.dart';
import 'package:flutter/material.dart';

class CallLog {
  String? sessionId;
  String? mid;
  String? receiverType;
  double? totalAudioMinutes = 0;
  double? totalVideoMinutes = 0;
  double? totalDurationInMinutes = 0;
  String? totalDuration;
  bool? hasRecording;
  String? mode;
  int? startedAt = 0;
  String? status;
  String? type;
  int? totalParticipants = 0;
  int? endedAt = 0;
  int? initiatedAt = 0;
  CallEntity? initiator;
  CallEntity? receiver;
  List<Participants>? participants;
  List<Recordings>? recordings;

  CallLog({
    this.sessionId,
    this.mid,
    this.receiverType,
    this.totalAudioMinutes,
    this.totalVideoMinutes,
    this.totalDurationInMinutes,
    this.totalDuration,
    this.hasRecording,
    this.mode,
    this.startedAt,
    this.status,
    this.type,
    this.totalParticipants,
    this.endedAt,
    this.initiatedAt,
    this.initiator,
    this.receiver,
    this.participants,
    this.recordings
  });

  CallLog.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
    if(json['totalAudioMinutes'] != null) totalAudioMinutes = json['totalAudioMinutes'].toDouble();
    if(json['totalVideoMinutes'] != null) totalVideoMinutes = json['totalVideoMinutes'].toDouble();
    totalDuration = json['totalDuration'];
    hasRecording = json['hasRecording'];
    if(json['initiatedAt'] != null) initiatedAt = json['initiatedAt'];
    mode = json['mode'];
    receiverType = json['receiverType'];
    status = json['status'];
    if(json['totalDurationInMinutes'] != null) totalDurationInMinutes = json['totalDurationInMinutes'].toDouble();
    totalParticipants = json['totalParticipants'];
    type = json['type'];
    mid = json['mid'];
    if(json['startedAt'] != null) startedAt = json['startedAt'];
    if(json['endedAt'] != null) endedAt = json['endedAt'];
    if(json['data'] != null){
      if(json['data']['entities'] != null){
        debugPrint("json['data']['entities']['initiator']: ${json['data']['entities']['initiator']}");
        if(json['data']['entities']['initiator'] != null){
          initiator = CallUser.fromJson(json['data']['entities']['initiator']['entity']);
        }
        if(receiverType == CometChatCallsConstants.receiverTypeGroup){
          receiver = CallGroup.fromJson(json['data']['entities']['receiver']['entity']);
        }else{
          receiver = CallUser.fromJson(json['data']['entities']['receiver']['entity']);
        }
      }
    }
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        Participants p = Participants.fromJson(v);
        participants!.add(p);
      });
    }
    if (json['recordings'] != null) {
      recordings = <Recordings>[];
      json['recordings'].forEach((v) {
        recordings!.add(Recordings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionId'] = sessionId;
    data['totalAudioMinutes'] = totalAudioMinutes;
    data['totalVideoMinutes'] = totalVideoMinutes;
    data['totalDuration'] = totalDuration;
    data['hasRecording'] = hasRecording;
    data['initiatedAt'] = initiatedAt;
    data['initiator'] = initiator;
    data['mode'] = mode;
    data['receiver'] = receiver;
    data['receiverType'] = receiverType;
    data['status'] = status;
    data['totalDurationInMinutes'] = totalDurationInMinutes;
    data['totalParticipants'] = totalParticipants;
    data['type'] = type;
    data['mid'] = mid;
    data['startedAt'] = startedAt;
    data['endedAt'] = endedAt;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    if (recordings != null) {
      data['recordings'] = recordings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}