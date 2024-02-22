package com.cometchatcalls.cometchatcalls_plugin.helper

/**
 * Created by Rohit Giri on 15/05/23.
 */
object PluginConstants {
    object Id {
        const val METHOD_CHANNEL_NAME = "cometchatcalls_plugin"
        const val EVENT_CHANNEL_NAME = "cometchatcalls_events_stream"
        const val CALLING_NATIVE_VIEW_ID = "cometchatcallsNativeViewAndroid"
    }

    object CometchatCallsInitArgumentsKeys {
        const val APP_ID = "appID"
        const val REGION = "region"
        const val HOST = "host"
    }

    object CometchatCallsGenerateTokenArgumentsKeys{
        const val SESSION_ID = "sessionId"
        const val USER_AUTH_TOKEN = "userAuthToken"
    }

    object CometchatCallsStartSessionArgumentsKeys{
        const val CALL_TOKEN = "callToken"
    }

    object Method{
        const val INIT_COMETCHAT_CALLS = "initCometChatCalls"
        const val GENERATE_TOKEN = "generateToken"
        const val START_SESSION = "startSession"
        const val JOIN_PRESENTATION = "joinPresentation"
        const val END_SESSION = "endSession"
        const val SWITCH_CAMERA = "switchCamera"
        const val MUTE_AUDIO = "muteAudio"
        const val PAUSE_VIDEO = "pauseVideo"
        const val SET_AUDIO_MODE = "setAudioMode"
        const val ENTER_PIP_MODE = "enterPIPMode"
        const val EXIT_PIP_MODE = "exitPIPMode"
        const val SWITCH_TO_VIDEO_CALL = "switchToVideoCall"
        const val START_RECORDING = "startRecording"
        const val STOP_RECORDING = "stopRecording"
        const val SUCCESS = "success"
        const val ERROR = "error"
    }

    object Code{
        const val SUCCESS = "SUCCESS"
        const val ERROR = "ERROR"
    }

    object ErrorMessage{
        const val GENERATED_TOKEN_NULL = "Generated token is null"
        const val CALL_TOKEN_NULL = "Call token is null"
        const val EVENT_STREAM_SINK_NULL = "Event stream sink is null"
        const val SETTINGS_METHOD_CALL_ERROR = "Unable to process your request"
        const val CALLS_SDK_NOT_INITIALIZED = "Please initialize the CometChatCalls by calling CometChatCalls.init() method"
        const val ARGUMENT_IS_NULL = "Passed argument is null"
    }

    object SuccessMessage{
        const val INIT = "CometChat SDK initialized successfully"
        const val SUCCESS = "success"
    }

}