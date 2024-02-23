import 'user.dart';

class MessageReaction {
  String? id;
  int? messageId;
  String? reaction;
  String? uid;
  int? reactedAt;
  User? reactedBy;

  MessageReaction({
    this.id,
    this.messageId,
    this.reaction,
    this.uid,
    this.reactedAt,
    this.reactedBy
  });

  factory MessageReaction.fromMap(dynamic map) {
    if (map == null) throw ArgumentError('The type of message reaction map is null');
    return MessageReaction(
      id: map['id'] ?? '',
      messageId: map['messageId'] ?? null,
      reaction: map['reaction'],
      uid: map['uid'],
      reactedAt: map['reactedAt'],
      reactedBy: map['reactedBy'] != null ? User.fromMap(map['reactedBy']) : null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['messageId'] = this.messageId;
    data['reaction'] = this.reaction;
    data['uid'] = this.uid;
    data['reactedAt'] = this.reactedAt;
    if (this.reactedBy != null) {
      data['reactedBy'] = this.reactedBy!.toJson();
    }
    return data;
  }
}