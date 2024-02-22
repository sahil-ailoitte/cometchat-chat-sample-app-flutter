class Recordings {
  double? duration;
  int? endTime;
  String? recordingUrl;
  String? rid;
  int? startTime;

  Recordings({
    this.duration,
    this.endTime,
    this.recordingUrl,
    this.rid,
    this.startTime
  });

  Recordings.fromJson(Map<String, dynamic> json) {
    if(json['duration'] != null) duration = json['duration'].toDouble();
    if(json['endTime'] != null) endTime = json['endTime'];
    recordingUrl = json['recording_url'];
    rid = json['rid'];
    if(json['startTime'] != null) startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['endTime'] = endTime;
    data['recording_url'] = recordingUrl;
    data['rid'] = rid;
    data['startTime'] = startTime;
    return data;
  }
}