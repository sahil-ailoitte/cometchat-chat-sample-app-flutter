class GenerateToken {
  String? sessionId;
  String? token;
  dynamic passThrough;

  GenerateToken({this.sessionId, this.token, this.passThrough});

  factory GenerateToken.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of GenerateToken map is null');
    return GenerateToken(
      token: map['message']
    );
  }

  GenerateToken.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
    token = json['token'];
    passThrough = json['passThrough'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionId'] = sessionId;
    data['token'] = token;
    data['passThrough'] = passThrough;
    return data;
  }
}