import 'call_entity.dart';

class CallUser extends CallEntity {
  String? uid;
  String? name;
  String? avatar;

  CallUser({
    this.uid,
    this.name,
    this.avatar
  });

  CallUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}