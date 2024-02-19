import 'dart:io' show Platform;

import '../../../cometchat_uikit_shared.dart';

///[SoundManager] is an utility component that provides an audio player
class SoundManager {

  ///[SoundManager] is a singleton class so use this to initialize the instance of this class.
 static final SoundManager _instance = SoundManager._internal();

 ///This method is used to get the instance of this class.
  factory SoundManager() => _instance;

  SoundManager._internal();

  void play(
      {required Sound sound,
      String? customSound,
      String? packageName // Use it only when using other plugin
      }) async {
    String _soundPath = "";

    if (customSound != null && customSound.isNotEmpty) {
      _soundPath = customSound;

      if (Platform.isAndroid && packageName != null && packageName.isNotEmpty) {
        _soundPath = "packages/$packageName/" + _soundPath;
      }
    } else {
      _soundPath = _getDefaultSoundPath(sound);
      packageName ??= UIConstants.packageName;
      if (Platform.isAndroid) {
        //if (packageName != null && packageName.isNotEmpty) {
        _soundPath = "packages/$packageName/" + _soundPath;
        // } else {
        //   _soundPath = "packages/${UIConstants.packageName}/" + _soundPath;
        // }
      }
    }

    await UIConstants.channel.invokeMethod("playCustomSound",
        {'assetAudioPath': _soundPath, 'package': packageName});
  }

  void stop() async {
    await UIConstants.channel.invokeMethod("stopPlayer", {});
  }

  String _getDefaultSoundPath(Sound sound) {
    String _soundType = "assets/beep.mp3";
    switch (sound) {
      case Sound.incomingMessage:
        _soundType = "assets/sound/incoming_message.wav";
        break;
      case Sound.outgoingMessage:
        _soundType = "assets/sound/outgoing_message.wav";
        break;
      case Sound.incomingMessageFromOther:
        _soundType = "assets/sound/incoming_message.wav";
        break;
      case Sound.outgoingCall:
        _soundType = "assets/sound/outgoing_call.wav";
        break;
      case Sound.incomingCall:
        _soundType = "assets/sound/incoming_call.wav";
        break;
      default:
        _soundType = "assets/beep.mp3";
        break;
    }

    return _soundType;
  }
}

enum Sound {
  incomingMessage,
  outgoingMessage,
  incomingMessageFromOther,
  outgoingCall,
  incomingCall
}
