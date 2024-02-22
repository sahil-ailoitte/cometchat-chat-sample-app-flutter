package com.cometchatcalls.cometchatcalls_plugin.wrapper

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.cometchat.calls.constants.CometChatCallsConstants
import com.cometchat.calls.core.CallAppSettings
import com.cometchat.calls.core.CometChatCalls
import com.cometchat.calls.exceptions.CometChatException
import com.cometchat.calls.model.GenerateToken
import com.cometchatcalls.cometchatcalls_plugin.helper.GetMappedObject
import com.cometchatcalls.cometchatcalls_plugin.helper.PluginConstants
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Created by Rohit Giri on 21/03/23.
 */
object CometChatCallsInteractor {
    private val TAG = javaClass.simpleName

    var isCometChatCallsSDKInitialized = false

    fun initCometChatCalls(call: MethodCall, activity: Activity, result: MethodChannel.Result){
        val appID: String = call.argument<String>(PluginConstants.CometchatCallsInitArgumentsKeys.APP_ID) as String
        val region: String = call.argument<String>(PluginConstants.CometchatCallsInitArgumentsKeys.REGION) as String
        val host: String ?= if(call.argument<String>(PluginConstants.CometchatCallsInitArgumentsKeys.HOST) != null){
            call.argument<String>(PluginConstants.CometchatCallsInitArgumentsKeys.HOST) as String
        } else {
            null
        }
        val callAppSettings = CallAppSettings.CallAppSettingBuilder()
            .setAppId(appID)
            .setRegion(region)
            .setHost(host)
            .build()
        CometChatCalls.init(
            activity,
            callAppSettings,
            object : CometChatCalls.CallbackListener<String>() {
                override fun onSuccess(s: String) {
                    isCometChatCallsSDKInitialized = true
                    Handler(Looper.getMainLooper()).post {
                        result.success(GetMappedObject.successMap(PluginConstants.SuccessMessage.INIT, PluginConstants.Method.SUCCESS))
                    }
                }

                override fun onError(e: CometChatException) {
                    isCometChatCallsSDKInitialized = false
                    Handler(Looper.getMainLooper()).post {
                        result.error(e.code, e.message, e.details)
                    }
                }
            }
        )
    }

    fun generateToken(call: MethodCall, result: MethodChannel.Result){
        val sessionId: String = call.argument<String>(PluginConstants.CometchatCallsGenerateTokenArgumentsKeys.SESSION_ID) as String
        val userAuthToken: String = call.argument<String>(PluginConstants.CometchatCallsGenerateTokenArgumentsKeys.USER_AUTH_TOKEN) as String
        CometChatCalls.generateToken(
            sessionId,
            userAuthToken,
            object : CometChatCalls.CallbackListener<GenerateToken>() {
                override fun onSuccess(generateToken: GenerateToken) {
                    Log.i(TAG, "Generated Token: " + generateToken.token)
                    if(generateToken.token != null) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(GetMappedObject.successMap(generateToken.token, PluginConstants.Method.SUCCESS))
                        }
                    }else{
                        val e = CometChatException(
                            CometChatCallsConstants.Errors.ERROR_CALL_TOKEN,
                            PluginConstants.ErrorMessage.GENERATED_TOKEN_NULL,
                            PluginConstants.ErrorMessage.GENERATED_TOKEN_NULL
                        )
                        Handler(Looper.getMainLooper()).post {
                            result.error(e.code, e.message, e.details)
                        }
                    }
                }

                override fun onError(e: CometChatException) {
                    Handler(Looper.getMainLooper()).post {
                        result.error(e.code, e.message, e.details)
                    }
                }
            }
        )
    }

    fun startSession(
        activity: Activity,
        call: MethodCall,
        result: MethodChannel.Result,
        callsEventsStreamSink: EventChannel.EventSink
    ){
        CometChatCallsPlatformViewFactory().initVariables(activity, call, result, callsEventsStreamSink)
        CometChatCallsPlatformViewFactory().initCallView()
    }

    fun joinPresentation(
        activity: Activity,
        call: MethodCall,
        result: MethodChannel.Result,
        callsEventsStreamSink: EventChannel.EventSink
    ){
        CometChatCallsPlatformViewFactory().initVariables(activity, call, result, callsEventsStreamSink)
        CometChatCallsPlatformViewFactory().initPresenterCallView()
    }

    fun endSession(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.endSession()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun switchCamera(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.switchCamera()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun muteAudio(flag: Boolean, result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.muteAudio(flag)
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun pauseVideo(flag: Boolean, result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.pauseVideo(flag)
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun setAudioMode(value: String, result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.setAudioMode(value)
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun enterPIPMode(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.enterPIPMode()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun exitPIPMode(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.exitPIPMode()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun switchToVideoCall(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.switchToVideoCall()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun startRecording(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.startRecording()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

    fun stopRecording(result: MethodChannel.Result){
        if (isCometChatCallsSDKInitialized){
            CometChatCalls.stopRecording()
            result.success(PluginConstants.SuccessMessage.SUCCESS)
        }else{
            result.error(PluginConstants.Code.ERROR, PluginConstants.ErrorMessage.SETTINGS_METHOD_CALL_ERROR, PluginConstants.ErrorMessage.CALLS_SDK_NOT_INITIALIZED)
        }
    }

}