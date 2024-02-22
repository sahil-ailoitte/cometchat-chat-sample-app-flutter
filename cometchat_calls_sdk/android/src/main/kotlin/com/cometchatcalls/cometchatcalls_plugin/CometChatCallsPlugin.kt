package com.cometchatcalls.cometchatcalls_plugin

import android.app.Activity
import com.cometchatcalls.cometchatcalls_plugin.helper.PluginConstants
import com.cometchatcalls.cometchatcalls_plugin.wrapper.CometChatCallsInteractor
import com.cometchatcalls.cometchatcalls_plugin.wrapper.CometChatCallsPlatformViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** CometchatcallsPlugin */
class CometChatCallsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler{
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var flutterBinding: FlutterPlugin.FlutterPluginBinding
    private lateinit var eventStream: EventChannel
    private var eventStreamSink: EventChannel.EventSink? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, PluginConstants.Id.METHOD_CHANNEL_NAME)
        channel.setMethodCallHandler(this)
        flutterBinding = flutterPluginBinding

        //For Event Channel
        eventStream = EventChannel(flutterPluginBinding.binaryMessenger, PluginConstants.Id.EVENT_CHANNEL_NAME)
        eventStream.setStreamHandler(this)
        //For native view
        flutterBinding.platformViewRegistry.registerViewFactory(
            PluginConstants.Id.CALLING_NATIVE_VIEW_ID, CometChatCallsPlatformViewFactory(),
        )
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            PluginConstants.Method.INIT_COMETCHAT_CALLS -> {
                CometChatCallsInteractor.initCometChatCalls(call, activity, result)
            }
            PluginConstants.Method.GENERATE_TOKEN -> {
                CometChatCallsInteractor.generateToken(call, result)
            }
            PluginConstants.Method.START_SESSION -> {
                if (eventStreamSink != null){
                    CometChatCallsInteractor.startSession(activity, call, result, eventStreamSink!!)
                }else{
                    result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.EVENT_STREAM_SINK_NULL, PluginConstants.ErrorMessage.EVENT_STREAM_SINK_NULL)
                }
            }
            PluginConstants.Method.JOIN_PRESENTATION -> {
                if (eventStreamSink != null){
                    CometChatCallsInteractor.joinPresentation(activity, call, result, eventStreamSink!!)
                }else{
                    result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.EVENT_STREAM_SINK_NULL, PluginConstants.ErrorMessage.EVENT_STREAM_SINK_NULL)
                }
            }
            PluginConstants.Method.END_SESSION -> {
                CometChatCallsInteractor.endSession(result)
            }
            PluginConstants.Method.SWITCH_CAMERA -> {
                CometChatCallsInteractor.switchCamera(result)
            }
            PluginConstants.Method.MUTE_AUDIO -> {
                val flag: Boolean? = call.argument<Boolean>("flag")
                if (flag != null){
                    CometChatCallsInteractor.muteAudio(flag, result)
                } else{
                    result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.ARGUMENT_IS_NULL)
                }
            }
            PluginConstants.Method.PAUSE_VIDEO -> {
                val flag: Boolean? = call.argument<Boolean>("flag")
                if (flag != null){
                    CometChatCallsInteractor.pauseVideo(flag, result)
                }else{
                    result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.ARGUMENT_IS_NULL)
                }
            }
            PluginConstants.Method.SET_AUDIO_MODE -> {
                val value: String? = call.argument<String>("value")
                if (value != null){
                    CometChatCallsInteractor.setAudioMode(value, result)
                } else {
                    result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.ARGUMENT_IS_NULL)
                }
            }
            PluginConstants.Method.ENTER_PIP_MODE -> {
                CometChatCallsInteractor.enterPIPMode(result)
            }
            PluginConstants.Method.EXIT_PIP_MODE -> {
                CometChatCallsInteractor.exitPIPMode(result)
            }
            PluginConstants.Method.SWITCH_TO_VIDEO_CALL -> {
                CometChatCallsInteractor.switchToVideoCall(result)
            }
            PluginConstants.Method.START_RECORDING -> {
                CometChatCallsInteractor.startRecording(result)
            }
            PluginConstants.Method.STOP_RECORDING -> {
                CometChatCallsInteractor.stopRecording(result)
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventStreamSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventStreamSink = null
    }
}
