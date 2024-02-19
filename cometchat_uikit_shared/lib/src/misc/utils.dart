import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/l10n/translations.dart';


class Utils {
  static const internetNotAvailable = "ERROR_INTERNET_UNAVAILABLE";

  static String getErrorTranslatedText(BuildContext context, String errorCode) {
    if (errorCode == internetNotAvailable) {
      return Translations.of(context).error_internet_unavailable;
    } else {}

    return Translations.of(context).something_went_wrong_error;
  }


  static bool isValidString(String? str){
    if(str==null||str.trim()=='' )return false;
    return true;
  }

  static bool isValidMap(Map? map){
    if(map==null||map.isEmpty)return false;
    return true;
  }

  static bool isValidInteger(int? integer){
    return integer!=null && integer>0;
  }

}
