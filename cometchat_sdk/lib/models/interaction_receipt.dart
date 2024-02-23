import 'dart:io' show Platform;
import 'package:cometchat_sdk/models/interaction.dart';

import '../models/user.dart';

class InteractionReceipt {
  int messageId;
  User sender;
  String receiverType;
  String receiverId;
  List<Interaction> interactions;

  InteractionReceipt({required this.messageId,
    required this.sender,
    required this.receiverType,
    required this.receiverId,
    required this.interactions
  });

  factory InteractionReceipt.fromMap(dynamic map) {
    late int messageId;
    if (Platform.isAndroid) {
      messageId = map['messageId'] ?? 0;
    } else if (Platform.isIOS) {
      messageId = int.parse(map['messageId'] ?? '0');

    } else {
      messageId = map['messageId'] ?? 0;
    }
    return InteractionReceipt(
      messageId: messageId,
      sender: User.fromMap(map['sender']),
      receiverType: map['receiverType'],
      receiverId: map['receiverId'],
      interactions:map['interactions'] != null?(map['interactions']).map<Interaction>((optionMap) => Interaction.fromMap(optionMap))
          .toList():null,
    );
  }

  @override
  String toString() {
    return 'InteractionReceipt{messageId: $messageId, sender: $sender, receiverType: $receiverType, receiverId: $receiverId, interactions: $interactions}';
  }
}
