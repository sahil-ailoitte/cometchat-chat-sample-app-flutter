import 'dart:math';
import 'package:cometchat_calls_sdk/cometchat_calls_sdk.dart';
import 'package:flutter/material.dart';

String appId = ""; //Your App ID
String region = ""; //Your App Region

class CometChatCallsDemo extends StatefulWidget {
  const CometChatCallsDemo({Key? key}) : super(key: key);

  @override
  State<CometChatCallsDemo> createState() => _CometChatCallsDemoState();
}

class _CometChatCallsDemoState extends State<CometChatCallsDemo> implements CometChatCallsEventsListener{
  String? sessionId;
  String? generateTokenResult;
  Widget? videoContainer;

  @override
  void initState() {
    super.initState();
    initCometChatCallsSDK();
  }

  //1. Initialize the CometChatCalls first
  initCometChatCallsSDK(){
    CallAppSettings callAppSettings= (CallAppSettingBuilder()
      ..appId = appId
      ..region= region
        //..host = "" //Add custom url here
    ).build();
    CometChatCalls.init(callAppSettings, onSuccess: (String successMessage) {
      debugPrint("Initialization completed successfully: $successMessage");
      generateToken(); //2. onSuccess call generateToken()
    }, onError: (CometChatCallsException e) {
      debugPrint("Initialization failed with exception: ${e.message}");
    });
  }

  //2. Generate Token
  Future<void> generateToken() async{
    String? userAuthToken = ""; //To get user auth token call -> CometChat.getUserAuthToken() method
    CometChatCalls.generateToken(generateNewSessionId(), userAuthToken, onSuccess: (GenerateToken generateToken){
      debugPrint("generateToken success: ${generateToken.token}");
      startCall(generateToken.token!); //3. Start the call
    }, onError: (CometChatCallsException e){
      debugPrint("generateToken Error: $e");
    });
  }

  //3. Start Call
  startCall(String generatedToken) async {
    //Optional settings
    MainVideoContainerSetting videoSettings = MainVideoContainerSetting();
    videoSettings.setMainVideoAspectRatio(CometChatCallsConstants.aspectRatioContain);
    videoSettings.setNameLabelParams(CometChatCallsConstants.positionTopLeft, true, "#000");
    videoSettings.setZoomButtonParams(CometChatCallsConstants.positionTopRight, true);
    videoSettings.setUserListButtonParams(CometChatCallsConstants.positionTopLeft, true);
    videoSettings.setFullScreenButtonParams(CometChatCallsConstants.positionTopRight, true);

    //Call settings builder
    CallSettings callSettings= (CallSettingsBuilder()
      ..enableDefaultLayout = true
      ..setMainVideoContainerSetting = videoSettings
      ..listener = this
    ).build();

    //Start the call
    CometChatCalls.startSession(generatedToken, callSettings, onSuccess: (Widget? callingWidget){
      setState(() {
        videoContainer = callingWidget;
      });
    }, onError: (CometChatCallsException e){
      debugPrint("Error: StartSession: $e");
    });
  }

  //Generate new session ID
  String generateNewSessionId(){
    return "${generateRandomString(4)}-${generateRandomString(4)}-${generateRandomString(4)}";
  }

  //Random string generator
  String generateRandomString(int len){
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  //Calls callback
  @override
  void onAudioModeChanged(List<AudioMode> devices) {
    debugPrint("onAudioModeChanged: ${devices.length}");
  }

  @override
  void onCallEndButtonPressed() {
    debugPrint("onCallEndButtonPressed");
  }

  @override
  void onCallEnded() {
    debugPrint("onCallEnded");
  }

  @override
  void onCallSwitchedToVideo(CallSwitchRequestInfo info) {
    debugPrint("onCallSwitchedToVideo: ${info.requestAcceptedBy}");
  }

  @override
  void onError(CometChatCallsException ce) {
    debugPrint("onError: ${ce.message}");
  }

  @override
  void onRecordingToggled(RTCRecordingInfo info) {
    debugPrint("onRecordingToggled: ${info.user?.name}");
  }

  @override
  void onUserJoined(RTCUser user) {
    debugPrint("onUserJoined: ${user.name}");
  }

  @override
  void onUserLeft(RTCUser user) {
    debugPrint("onUserLeft: ${user.name}");
  }

  @override
  void onUserListChanged(List<RTCUser> users) {
    debugPrint("onUserListChanged: ${users.length}");
  }

  @override
  void onUserMuted(RTCMutedUser muteObj) {
    debugPrint("onUserMuted: ${muteObj.mutedBy}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: SafeArea(
        child: videoContainer ?? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
