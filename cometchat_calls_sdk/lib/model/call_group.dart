import 'call_entity.dart';

class CallGroup extends CallEntity {
  String? guid;
  String? name;
  String? icon;

  CallGroup({
    this.guid,
    this.name,
    this.icon
  });

  CallGroup.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['guid'] = guid;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}