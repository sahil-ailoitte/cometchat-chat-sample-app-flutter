import '../../../../cometchat_uikit_shared.dart';

/// Represents a label model class , used to draw label .
class LabelElement extends ElementEntity{
  String text;

  LabelElement({
     String elementType =  UIElementTypeConstants.label,
    required String elementId,
    required this.text
  }):super(
      elementType: elementType,
      elementId: elementId,
  );


  @override
  Map<String, dynamic> toMap(){
    Map<String,dynamic> map = super.toMap();
    map[ModelFieldConstants.text] = text;
    return map;
  }




  factory LabelElement.fromMap(dynamic map){
    return LabelElement(
      elementType: map[ModelFieldConstants.elementType],
      elementId: map[ModelFieldConstants.elementId] ,
      text:  map[ModelFieldConstants.text],
    );
  }

}