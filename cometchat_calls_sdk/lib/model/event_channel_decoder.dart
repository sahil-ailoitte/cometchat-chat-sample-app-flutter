class EventChannelDecode {
  String? eventReceivedData;
  String? methodName;

  EventChannelDecode({this.eventReceivedData, this.methodName});

  factory EventChannelDecode.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of action map is null');

    return EventChannelDecode(
      eventReceivedData: map['message'] ?? '',
      methodName: map['methodName'] ?? '',
    );
  }

  EventChannelDecode.fromJson(Map<String, dynamic> json) {
    eventReceivedData = json['message'];
    methodName = json['methodName'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = eventReceivedData;
    data['methodName'] = methodName;
    return data;
  }
}
