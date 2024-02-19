import 'package:flutter/material.dart';

import '../../../../cometchat_uikit_shared.dart';

/// Represents a dropdown model class , used to draw dropdown .
class DateTimeElement extends BaseInputElement<String> {
  DateTimeElement(
      {String elementType = UIElementTypeConstants.dropdown,
        required String elementId,
        required this.label,
        this.mode = DateTimeVisibilityMode.dateTime,
        this.from,
        this.to,
        this.placeholder,
        this.dateTimeFormat,
        this.defaultDateTime,
        String? response,
        String? defaultValue,
        bool? optional,
        this.formattedResponse
      })
      : super(
      elementType: elementType,
      elementId: elementId,
      defaultValue: defaultValue,
      optional: optional ?? true);


  String label;
  DateTimeVisibilityMode mode;
  DateTime? from;
  DateTime? to;
  TextInputPlaceholder? placeholder;
  DateTime? formattedResponse;
  String? dateTimeFormat;
  DateTime? defaultDateTime;




  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map[ModelFieldConstants.label] = label;
    return map;
  }

  factory DateTimeElement.fromMap(dynamic map) {

    DateTimeVisibilityMode _mode;

    switch(map[ModelFieldConstants.mode]){
      case "date":
        _mode = DateTimeVisibilityMode.date;
        break;
      case "dateTime":
        _mode = DateTimeVisibilityMode.dateTime;
        break;
      case "time":
        _mode = DateTimeVisibilityMode.time;
        break;
      default:
        _mode = DateTimeVisibilityMode.dateTime;
        break;
    }

    DateTime? from;
    DateTime? to;
    DateTime? _defaultDateTime;

    try{
      if(_mode== DateTimeVisibilityMode.time){
        from  =  DateTime.parse( ("${cometchatConstantString}"+map[ModelFieldConstants.from]));
        _defaultDateTime  =  DateTime.parse( ("${cometchatConstantString}"+map[ModelFieldConstants.defaultValue]));
      }else{
        from = DateTime.parse(map[ModelFieldConstants.from]);
        _defaultDateTime = DateTime.parse(map[ModelFieldConstants.defaultValue]);
      }
    } catch(_){}

    try{
      if(_mode== DateTimeVisibilityMode.time){
        to  =  DateTime.parse( ("${cometchatConstantString}"+map[ModelFieldConstants.to]));

      }else{
        to = DateTime.parse(map[ModelFieldConstants.to]);
      }
    } catch(_){
    }


    print("_defaultDateTime is ${_defaultDateTime}");
    return DateTimeElement(
      elementType: map[ModelFieldConstants.elementType],
      elementId: map[ModelFieldConstants.elementId],
      optional: map[ModelFieldConstants.optional],
      label: map[ModelFieldConstants.label],
      defaultValue:  map[ModelFieldConstants.defaultValue],
      defaultDateTime: _defaultDateTime,
      formattedResponse: _defaultDateTime,
      //response:map[ModelFieldConstants.response],
        mode: _mode,
      placeholder: map[ModelFieldConstants.placeholder],
      from: from,
      to: to,
      dateTimeFormat:  map[ModelFieldConstants.dateTimeFormat],
    );
  }

  @override
  bool validateResponse() {
    if (response == null) return false;
    return true;
  }
}

String cometchatConstantString = "1970-01-01T";
