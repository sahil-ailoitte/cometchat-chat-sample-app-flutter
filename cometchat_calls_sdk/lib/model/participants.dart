class Participants {
  String? uid;
  double? totalAudioMinutes = 0;
  double? totalVideoMinutes = 0;
  double? totalDurationInMinutes = 0;
  String? deviceId;
  bool? isJoined;
  int? joinedAt = 0;
  String? mid;
  String? state;
  int? leftAt = 0;
  String? name;
  String? avatar;

  Participants({
    this.uid,
    this.totalAudioMinutes,
    this.totalVideoMinutes,
    this.totalDurationInMinutes,
    this.deviceId,
    this.isJoined,
    this.joinedAt,
    this.mid,
    this.state,
    this.leftAt,
    this.name,
    this.avatar
  });

  Participants.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    if(json['totalAudioMinutes'] != null) totalAudioMinutes = json['totalAudioMinutes'].toDouble();
    if(json['totalVideoMinutes'] != null) totalVideoMinutes = json['totalVideoMinutes'].toDouble();
    if(json['totalDurationInMinutes'] != null) totalDurationInMinutes = json['totalDurationInMinutes'].toDouble();
    deviceId = json['deviceId'];
    isJoined = json['isJoined'];
    if(json['joinedAt'] != null) joinedAt = json['joinedAt'];
    mid = json['mid'];
    state = json['state'];
    if(json['leftAt'] != null) leftAt = json['leftAt'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['totalAudioMinutes'] = totalAudioMinutes;
    data['totalVideoMinutes'] = totalVideoMinutes;
    data['totalDurationInMinutes'] = totalDurationInMinutes;
    data['deviceId'] = deviceId;
    data['isJoined'] = isJoined;
    data['joinedAt'] = joinedAt;
    data['mid'] = mid;
    data['state'] = state;
    data['leftAt'] = leftAt;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}