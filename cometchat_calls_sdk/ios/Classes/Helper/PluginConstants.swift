import Foundation

class PluginConstants {
    
    @objc public enum Id:Int {
        case CALLING_NATIVE_VIEW_ID
        case METHOD_CHANNEL_NAME
        case EVENT_CHANNEL_NAME
        
        var value: String {
            switch self {
            case .CALLING_NATIVE_VIEW_ID:
                return "cometchatcallsNativeViewiOS"
            case .METHOD_CHANNEL_NAME:
                return "cometchatcalls_plugin"
            case .EVENT_CHANNEL_NAME:
                return "cometchatcalls_events_stream"
            }
        }
    }
    
    @objc public enum Method:Int {
        case INIT_COMETCHAT_CALLS
        case GENERATE_TOKEN
        case START_SESSION
        case END_SESSION
        case SWITCH_CAMERA
        case MUTE_AUDIO
        case PAUSE_VIDEO
        case SET_AUDIO_MODE
        case ENTER_PIP_MODE
        case EXIT_PIP_MODE
        case SWITCH_TO_VIDEO_CALL
        case START_RECORDING
        case STOP_RECORDING
        
        var value: String {
            switch self {
                
            case .INIT_COMETCHAT_CALLS:
                return "initCometChatCalls"
            case .GENERATE_TOKEN:
                return "generateToken"
            case .START_SESSION:
                return "startSession"
            case .END_SESSION:
                return "endSession"
            case .SWITCH_CAMERA:
                return "switchCamera"
            case .MUTE_AUDIO:
                return "muteAudio"
            case .PAUSE_VIDEO:
                return "pauseVideo"
            case .SET_AUDIO_MODE:
                return "setAudioMode"
            case .ENTER_PIP_MODE:
                return "enterPIPMode"
            case .EXIT_PIP_MODE:
                return "exitPIPMode"
            case .SWITCH_TO_VIDEO_CALL:
                return "switchToVideoCall"
            case .START_RECORDING:
                return "startRecording"
            case .STOP_RECORDING:
                return "stopRecording"
            }
        }
    }
    
    @objc public enum ErrorMessage:Int {
        case GENERATED_TOKEN_NULL
        case CALL_TOKEN_NULL
        case EVENT_STREAM_SINK_NULL
        case SETTINGS_METHOD_CALL_ERROR
        case CALLS_SDK_NOT_INITIALIZED
        case ARGUMENT_IS_NULL
        
        var value: String {
            switch self {
                
            case .GENERATED_TOKEN_NULL:
                return "Generated token is null"
            case .CALL_TOKEN_NULL:
                return "Call token is null"
            case .EVENT_STREAM_SINK_NULL:
                return "Event stream sink is null"
            case .SETTINGS_METHOD_CALL_ERROR:
                return "Unable to process your request"
            case .CALLS_SDK_NOT_INITIALIZED:
                return "Please initialize the CometChatCalls by calling CometChatCalls.init() method"
            case .ARGUMENT_IS_NULL:
                return "Passed argument is null"
            }
        }
    }
    
    @objc public enum SuccessMessage:Int {
        case INIT
        case SUCCESS
        
        var value: String {
            switch self {
                
            case .INIT:
                return "CometChat SDK initialized successfully"
            case .SUCCESS:
                return "success"
            }
        }
    }
    
    
    @objc public enum Code:Int {
        case SUCCESS
        case ERROR
        
        var value:String {
            switch self {
            case .ERROR:
                return "ERROR"
            case .SUCCESS:
                return "SUCCESS"
            }
        }
    }
    
    @objc public enum Position:Int {
        
        case TOP_LEFT
        case TOP_RIGHT
        case BOTTOM_LEFT
        case BOTTOM_RIGHT
        
        var value:String {
            
            switch self {
                
            case .TOP_LEFT:
                return "top-left"
            case .TOP_RIGHT:
                return "top-right";
            case .BOTTOM_LEFT:
                return "bottom-left";
            case .BOTTOM_RIGHT:
                return "bottom-right";
            }
        }
    }
    
    @objc public enum AspectRatio:Int {
        
        case DEFAULT
        case CONTAIN
        case COVER
        
        var value:String {
            
            switch self {
                
            case .DEFAULT:
                fallthrough
            case .CONTAIN:
                return "contain";
            case .COVER:
                return "cover";
            }
        }
    }
}
