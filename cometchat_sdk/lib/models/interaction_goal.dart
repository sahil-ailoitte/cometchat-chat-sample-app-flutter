class InteractionGoal {
  String type;
  List<String> elementIds ;

  InteractionGoal({required this.type, this.elementIds = const  []});

  List<String> getElementIds() {
    return elementIds;
  }

  void setElementIds(List<String> elementIds) {
    this.elementIds = elementIds;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type, // Assuming ActionType is an enum
      'elementIds': elementIds,
    };
  }

  // Create an InteractionGoal object from a Map
  factory InteractionGoal.fromMap(dynamic map) {
    final  String  type = map?['type']??"none";
    final List<String> elementIds = List<String>.from(map?['elementIds']??[]);
    return InteractionGoal(type: type, elementIds: elementIds);
  }

  @override
  String toString() {
    return 'InteractionGoal{type: $type, elementIds: $elementIds}';
  }


}

