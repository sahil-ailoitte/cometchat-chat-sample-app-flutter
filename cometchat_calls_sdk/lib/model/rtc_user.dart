class RTCUser {
  String? uid;
  String? avatar;
  String? name;
  String? jwt;
  String? resource;

  RTCUser({this.uid, this.avatar, this.name, this.jwt, this.resource});

  RTCUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    name = json['name'];
    jwt = json['jwt'];
    resource = json['resource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['avatar'] = avatar;
    data['name'] = name;
    data['jwt'] = jwt;
    data['resource'] = resource;
    return data;
  }

  factory RTCUser.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of action map is null');
    return RTCUser(
      uid: map['uid'],
      avatar: map['avatar'],
      name: map['name'],
      jwt: map['jwt'],
      resource: map['resource'],
    );
  }

}