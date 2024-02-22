import Flutter
import UIKit
import CometChatCallsSDK

public class SwiftCometchatcallsPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    
    static var cometchatCallsPlatformViewFactory = CometChatCallsPlatformViewFactory()
    var eventSink: FlutterEventSink?
        
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let instance = SwiftCometchatcallsPlugin()
        
        //For Method Channel
        let channel = FlutterMethodChannel(name: PluginConstants.Id.METHOD_CHANNEL_NAME.value, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        
        //For adding View
        registrar.register(cometchatCallsPlatformViewFactory, withId: PluginConstants.Id.CALLING_NATIVE_VIEW_ID.value)
        
        
        //For Event channel
        let eventChannel = FlutterEventChannel(name: PluginConstants.Id.EVENT_CHANNEL_NAME.value, binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        
        let args = call.arguments as? [String: Any] ?? [String: Any]()
        print("iOS SwiftCometchatcallsPlugin: \(call.method) called from dart with arg \(args)")
        
        
        switch call.method{
            
        case "initCometChatCalls":
            CometChatCallsInteractor.initCometChatCalls(arg: args, result: result)
            
        case "generateToken":
            CometChatCallsInteractor.generateToken(arg: args, result: result)
            
        case "startSession":
            CometChatCallsInteractor.startSession(cometchatCallsPlatformViewFactory: SwiftCometchatcallsPlugin.cometchatCallsPlatformViewFactory, result: result, call: call, eventSink: eventSink)
            
        case "endSession":
            CometChatCallsInteractor.endSession(result: result)
            
        case "switchCamera":
            CometChatCallsInteractor.switchCamera(result: result)
            
        case "muteAudio":
            CometChatCallsInteractor.muteAudio(arg: args, result: result)
            
        case "pauseVideo":
            CometChatCallsInteractor.pauseVideo(arg: args, result: result)
            
        case "setAudioMode":
            CometChatCallsInteractor.setAudioMode(arg: args, result: result)
            
        case "enterPIPMode":
            CometChatCallsInteractor.enterPIPMode(result: result)
            
        case "exitPIPMode":
            CometChatCallsInteractor.exitPIPMode(result: result)
            
        case "switchToVideoCall":
            CometChatCallsInteractor.switchToVideoCall(result: result)
            
        case "startRecording":
            CometChatCallsInteractor.startRecording(result: result)
            
        case "stopRecording":
            CometChatCallsInteractor.stopRecording(result: result)
            
        case "joinPresentation":
            CometChatCallsInteractor.joinPresentation(cometchatCallsPlatformViewFactory: SwiftCometchatcallsPlugin.cometchatCallsPlatformViewFactory, result: result, call: call, eventSink: eventSink)
            
        default:
            print("method not found")
            result("method not found")
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

}
