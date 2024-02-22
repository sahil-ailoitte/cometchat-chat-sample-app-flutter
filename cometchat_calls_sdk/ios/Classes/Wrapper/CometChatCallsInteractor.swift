import Foundation
import CometChatCallsSDK
import Flutter

class CometChatCallsInteractor {
    
    static var isInitialised: Bool = false
    
    static func initCometChatCalls(arg: [String : Any], result: @escaping FlutterResult){
        
        print("iOS CometChatCallsInteractor: initCometChatCalls initiated...")
        let appID = arg["appID"] as? String ?? ""
        let region = arg["region"] as? String ?? ""
        let host = arg["host"] as? String
        
        let callAppSettings = CallAppSettingsBuilder()
            .setAppId(appID)
            .setRegion(region)
            .setHost(host ?? nil)
            .build()
        
        CometChatCalls.init(callsAppSettings: callAppSettings) { success in
            isInitialised = true
            print("iOS CometChatCallsInteractor: Init success with message \(success)")
            result(GetMappedObject.resultMap(msg: "CometChat SDK initialized successfully", methodName: "success"))
        } onError: { error in
            isInitialised = false
            print("iOS CometChatCallsInteractor: Init failed with error \(String(describing: error))")
            result(FlutterError(code: error?.errorCode ?? "INIT ERROR", message: error?.description, details: error?.description))
        }

        print("iOS CometChatCallsInteractor: initCometChatCalls initiated ended....")
    }
    
    static func generateToken(arg: [String : Any], result: @escaping FlutterResult){
        print("iOS CometChatCallsInteractor: generateToken initiated...")
        let authToken = arg["userAuthToken"] as? NSString
        let sessionID = arg["sessionId"] as? NSString
        
        CometChatCalls.generateToken(authToken: authToken, sessionID: sessionID) { token in
            print("iOS CometChatCallsInteractor: generateToken success")
            print("iOS CometChatCallsInteractor call token: \(String(describing: token))")
            result(GetMappedObject.resultMap(msg: token, methodName: "success"))
        } onError: { error in
            print("iOS CometChatCallsInteractor: generateToken failed with error \(String(describing: error))")
            result(FlutterError(code: error?.errorCode ?? "GENERATE TOKEN ERROR", message: error?.description, details: error?.description))
        }
    }
    
    static func startSession(
        cometchatCallsPlatformViewFactory: CometChatCallsPlatformViewFactory ,
        result: @escaping FlutterResult,
        call: FlutterMethodCall,
        eventSink: FlutterEventSink?
    ){
        let arg = call.arguments as! [String : Any]
        let callToken = arg["callToken"]
        
        cometchatCallsPlatformViewFactory.initData(messenger: nil, callToken: callToken as! String, call: call, result: result, eventSink: eventSink)
        
        cometchatCallsPlatformViewFactory.startNormalCall()
        
        print("iOS CometChatCallsInteractor: flutterPluginRegistrar done")
  
    }
    
    static func endSession(result: @escaping FlutterResult) {
        
        if isInitialised {
            CometChatCalls.endSession()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED.value))
        }
    }
    
    static func switchCamera(result: @escaping FlutterResult) {
        
        if isInitialised {
            CometChatCalls.switchCamera()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED.value))
        }
        
    }
    
    static func muteAudio(arg: [String : Any], result: @escaping FlutterResult) {
        
        if isInitialised {
            let muteFlag = arg["flag"] as? Bool
            guard let muteFlag = muteFlag else {
                result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.ARGUMENT_IS_NULL.value, details: PluginConstants.ErrorMessage.ARGUMENT_IS_NULL.value))
                return
            }
            CometChatCalls.audioMuted(muteFlag)
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
    }
    
    static func pauseVideo(arg: [String : Any], result: @escaping FlutterResult) {
        
        if isInitialised {
            let flag = arg["flag"] as? Bool
            guard let flag = flag else {
                result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.ARGUMENT_IS_NULL.value, details: PluginConstants.ErrorMessage.ARGUMENT_IS_NULL.value))
                return
            }
            CometChatCalls.videoPaused(flag)
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
    }
    
    static func setAudioMode(arg: [String : Any], result: @escaping FlutterResult) {
        
        if isInitialised {
            let mode = arg["value"] as? String
            guard let mode = mode else {
                result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.ARGUMENT_IS_NULL.value, details: PluginConstants.ErrorMessage.ARGUMENT_IS_NULL.value))
                return
            }
            CometChatCalls.setAudioMode(mode: mode)
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
        
    }
    
    static func enterPIPMode(result: @escaping FlutterResult) {
        
        if isInitialised {
            CometChatCalls.enterPIPMode()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
        
        result(true)
    }
    
    static func exitPIPMode(result: @escaping FlutterResult)  {
        if isInitialised {
            CometChatCalls.exitPIPMode()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
    }
    
    static func switchToVideoCall(result: @escaping FlutterResult) {
        
        if isInitialised {
            CometChatCalls.switchToVideoCall()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
    }
    
    static func startRecording(result: @escaping FlutterResult) {
        
        if isInitialised {
            CometChatCalls.startRecording()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
    }
    
    static func stopRecording(result: @escaping FlutterResult) {
        
        if isInitialised {
            CometChatCalls.stopRecording()
            result(PluginConstants.SuccessMessage.SUCCESS.value)
        }else {
            result(FlutterError(code: PluginConstants.Code.ERROR.value, message: PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR.value, details: PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED))
        }
        
    }
    
    static func joinPresentation(
        cometchatCallsPlatformViewFactory: CometChatCallsPlatformViewFactory,
        result: @escaping FlutterResult,
        call: FlutterMethodCall,
        eventSink: FlutterEventSink?
    ){
        let arg = call.arguments as! [String : Any]
        let callToken = arg["callToken"]
        
        cometchatCallsPlatformViewFactory.initData(messenger: nil, callToken: callToken as! String, call: call, result: result, eventSink: eventSink)
        
        cometchatCallsPlatformViewFactory.startPresenterModeCall()
        
        print("iOS CometChatCallsInteractor: flutterPluginRegistrar done")

    }
}
