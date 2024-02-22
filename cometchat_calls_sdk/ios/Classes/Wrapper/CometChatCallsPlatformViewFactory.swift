import Foundation
import Flutter
import CometChatCallsSDK
import UIKit

class CometChatCallsPlatformViewFactory: NSObject, FlutterPlatformViewFactory, CallsEventsDelegate {
    private var messenger: FlutterBinaryMessenger?
    private var callToken: String?
    private var call: FlutterMethodCall?
    private var result: FlutterResult?
    private var view = UIView()
    private var eventSink: FlutterEventSink?
    
    //This fun will be called by FlutterPlatformViewFactory for creating native view
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        print("iOS CometChatCallsPlatformViewFactory create: here")
        return CometChatCallsPlatformView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            view: view)
    }
    
    //This will initialise the data for the call
    func initData(messenger: FlutterBinaryMessenger?,
                callToken: String,
                call: FlutterMethodCall,
                result: @escaping (FlutterResult),
                eventSink: FlutterEventSink?
    ){
        self.messenger = messenger
        self.callToken = callToken
        self.call = call
        self.result = result
        self.eventSink = eventSink
        
        print("iOS CometChatCallsPlatformViewFactory setData: here")
    }
    
    //this func will set up call settings form arg and start the call
    func startNormalCall(){
        
        DispatchQueue.main.async {
            
            //assigning new UIView for second time call start 
            self.view = UIView()
            
            let arg = self.call?.arguments as? [String: Any]
            
            //View Settings
            let videoSettings = MainVideoContainerSetting()
            videoSettings.setMainVideoAspectRatio(arg?["videoFit"] as? String ?? "contain")
            videoSettings.setFullScreenButtonParams(
                ((arg?["fullScreenButtonVisibility"] as? Bool) ?? true),
                (((arg?["fullScreenButtonPosition"]) as? String) ?? "bottom-right")
            )
            
            videoSettings.setZoomButtonParams(
                ((arg?["zoomButtonVisibility"] as? Bool) ?? true),
                (((arg?["zoomButtonPosition"]) as? String) ?? "bottom-right")
                
            )
            
            videoSettings.setNameLabelParams(
                ((arg?["userListButtonVisibility"] as? Bool) ?? true),
                (((arg?["userListButtonPosition"]) as? String) ?? "bottom-right"),
                (((arg?["nameLabelColor"]) as? String) ?? "#333333")
            )
            
            videoSettings.setUserListButtonParams(
                ((arg?["userListButtonPosition"] as? Bool) ?? true),
                (((arg?["userListButtonVisibility"]) as? String) ?? "bottom-right")
                
            )
            
            print("iOS videoSettings: \(videoSettings.getDictionaryForVideoSetting())")
            
            //Main Call Settings
            let callSettings = CometChatCalls.callSettingsBuilder
                .setDefaultLayout((arg?["defaultLayout"] as? Bool) ?? true)
                .setIsAudioOnly((arg?["isAudioOnly"] as? Bool) ?? false)
                .setIsSingleMode((arg?["isSingleMode"] as? Bool) ?? false)
                .setShowSwitchToVideoCall((arg?["showSwitchToVideoCall"] as? Bool) ?? false)
                .setEnableVideoTileClick((arg?["enableVideoTileClick"] as? Bool) ?? true)
                .setEnableDraggableVideoTile((arg?["enableDraggableVideoTile"] as? Bool) ?? true)
                .setEndCallButtonDisable((arg?["endCallButtonDisable"] as? Bool) ?? false)
                .setShowRecordingButton((arg?["showRecordingButton"] as? Bool) ?? true)
                .setSwitchCameraButtonDisable((arg?["switchCameraButtonDisable"] as? Bool) ?? false)
                .setStartRecordingOnCallStart((arg?["startRecordingOnCallStart"] as? Bool) ?? false)
                .setMuteAudioButtonDisable((arg?["muteAudioButtonDisable"] as? Bool) ?? false)
                .setPauseVideoButtonDisable((arg?["pauseVideoButtonDisable"] as? Bool) ?? false)
                .setAudioModeButtonDisable((arg?["audioModeButtonDisable"] as? Bool) ?? false)
                .setStartAudioMuted((arg?["startAudioMuted"] as? Bool) ?? true)
                .setStartVideoMuted((arg?["startVideoMuted"] as? Bool) ?? false)
                .setAvatarMode((arg?["avatarMode"] as? NSString) ?? "CIRCLE")
                .setMode((arg?["mode"] as? NSString) ?? "DEFAULT")
                .setDefaultAudioMode((arg?["defaultAudioMode"] as? NSString) ?? "SPEAKER")
                .setVideoSettings(videoSettings.getDictionaryForVideoSetting())
                .setDelegate(self)
                .build()
            
            print("CometChatiOS: Starting Section...")
            guard let callToken = self.callToken else {
                print("CometChatiOS: Error no Auth token")
                return
            }
            
            print("CometChatiOS call token: \(callToken)")
            
            CometChatCalls.startSession(callToken: callToken, callSetting: callSettings, view: self.view) { response in
                print("CometChatiOS: Session response \(response)")
                self.result?(GetMappedObject.resultMap(msg: response, methodName: "success"))
            } onError: { error in
                print("CometChatiOS: Session start failed with error \(String(describing: error?.description))")
                self.result?(FlutterError(code: error?.errorCode ?? "START SESSION ERROR", message: error?.description, details: error?.description))
            }
        }
    }
    
    func startPresenterModeCall() {
        
        DispatchQueue.main.async {
            
            //assigning new UIView for second time call start
            self.view = UIView()
            
            let arg = self.call?.arguments as? [String: Any]
            
            //Presentation Call Settings
            let presentationSettings = CometChatCalls.presentationSettingsBuilder
                .setDefaultLayout((arg?["defaultLayout"] as? Bool) ?? true)
                .setIsAudioOnly((arg?["isAudioOnly"] as? Bool) ?? false)
                .setEndCallButtonDisable((arg?["endCallButtonDisable"] as? Bool) ?? false)
                .setShowRecordingButton((arg?["showRecordingButton"] as? Bool) ?? true)
                .setSwitchCameraButtonDisable((arg?["switchCameraButtonDisable"] as? Bool) ?? false)
                .setMuteAudioButtonDisable((arg?["muteAudioButtonDisable"] as? Bool) ?? false)
                .setPauseVideoButtonDisable((arg?["pauseVideoButtonDisable"] as? Bool) ?? false)
                .setAudioModeButtonDisable((arg?["audioModeButtonDisable"] as? Bool) ?? false)
                .setStartAudioMuted((arg?["startAudioMuted"] as? Bool) ?? true)
                .setStartVideoMuted((arg?["startVideoMuted"] as? Bool) ?? false)
                .setDefaultAudioMode((arg?["defaultAudioMode"] as? NSString) ?? "BLUETOOTH")
                .setIsPresenter(arg?["isPresenter"] as? Bool ?? false)
                .setDelegate(self)
                .build()
            
            print("CometChatiOS: Starting Section...")
            guard let callToken = self.callToken else {
                print("CometChatiOS: Error no Auth token")
                return
            }
            
            print("CometChatiOS call token: \(callToken)")
            
            CometChatCalls.joinPresentation(callToken: callToken, presenterSettings: presentationSettings, view: self.view) { response in
                print("CometChatiOS: Session response \(response)")
                self.result?(GetMappedObject.resultMap(msg: response, methodName: "success"))
            } onError: { error in
                print("CometChatiOS: Session start failed with error \(String(describing: error?.errorDescription))")
                self.result?(FlutterError(code: error?.errorCode ?? "START PRESENTATION ERROR", message: error?.description, details: error?.description))
            }
        }
        
    }
    
    //MARK: CALL EVENT DELEGATE
    func onCallEnded() {
        print("CometChatCalls-Ios: call ended")
        eventSink?(GetMappedObject.boolMap(flag: true, methodName: "onCallEnded"))
    }
    
    func onCallEndButtonPressed() {
        print("CometChatCalls-Ios: onCallEndButtonPressed")
        eventSink?(GetMappedObject.boolMap(flag: true, methodName: "onCallEndButtonPressed"))
    }
    
    func onUserJoined(user: NSDictionary) {
        print("CometChatCalls-Ios: onUserJoined")
        eventSink?(GetMappedObject.rtcUserMap(rtcUser: user, methodName: "onUserJoined"))
    }
    
    func onUserLeft(user: NSDictionary) {
        print("CometChatCalls-Ios: onUserLeft")
        eventSink?(GetMappedObject.rtcUserMap(rtcUser: user, methodName: "onUserLeft"))
    }
    
    func onUserListChanged(userList: NSArray) {
        print("CometChatCalls-Ios: onUserListChanged")
        eventSink?(GetMappedObject.rtcUserListMap(rtcUserList: userList))
    }
    
    func onAudioModeChanged(audioModeList: NSArray) {
        print("CometChatCalls-Ios: onAudioModeChanged")
        eventSink?(GetMappedObject.audioModeListMap(audioModeList: audioModeList, methodName: "onAudioModeChanged") ?? nil)
        
    }
    
    func onCallSwitchedToVideo(info: NSDictionary) {
        print("CometChatCalls-Ios: onCallSwitchedToVideo")
        eventSink?(GetMappedObject.callSwitchRequestInfoMap(callSwitchRequestInfo: info, methodName: "onCallSwitchedToVideo"))
    }
    
    func onUserMuted(info: NSDictionary) {
        print("CometChatCalls-Ios: onUserMuted \(info)")
        eventSink?(GetMappedObject.rtcMutedUserMap(rtcMutedUser: info, methodName: "onUserMuted   "))
    }
    
    func onRecordingToggled(info: NSDictionary) {
        print("CometChatCalls-Ios: onRecordingToggled \(info)")
        eventSink?(GetMappedObject.rtcRecordingInfoMap(rtcRecordingInfo: info, methodName: "onRecordingToggled"))
    }

}
