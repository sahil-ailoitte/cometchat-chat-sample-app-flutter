
class Interaction{

  Interaction({ required this.elementId, required this.interactedAt});

  String elementId;
  DateTime interactedAt;

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map["elementId"] = elementId;
    map["interactedAt"] = interactedAt.millisecondsSinceEpoch;
    return map;
  }


  factory Interaction.fromMap(dynamic map) {
    return Interaction(
      elementId:  map['elementId'],
      interactedAt:map['interactedAt']!=null? DateTime.fromMillisecondsSinceEpoch(map['interactedAt'] * 1000)
          :DateTime.now(),

    );
  }

  @override
  String toString() {
    return 'Interaction{elementId: $elementId, interactedAt: $interactedAt}';
  }


}