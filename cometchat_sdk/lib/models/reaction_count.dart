class ReactionCount {
  String? reaction;
  int? count;
  bool? reactedByMe;

  ReactionCount({this.reaction, this.count, this.reactedByMe});

  factory ReactionCount.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of reaction map is null');
    return ReactionCount(
      reaction: map['reaction'] ?? '',
      count: map['count'] ?? '',
      reactedByMe: map['reactedByMe'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reaction'] = this.reaction;
    data['count'] = this.count;
    data['reactedByMe'] = this.reactedByMe;
    return data;
  }
}
