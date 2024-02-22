import 'dart:io';

import 'package:flutter/foundation.dart';

class CometChatCallsUtils{
  static Future<bool> checkNetwork() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  static showLog(String tag, String log){
    if(kDebugMode){
      debugPrint("$tag >>>: $log");
    }
  }

}