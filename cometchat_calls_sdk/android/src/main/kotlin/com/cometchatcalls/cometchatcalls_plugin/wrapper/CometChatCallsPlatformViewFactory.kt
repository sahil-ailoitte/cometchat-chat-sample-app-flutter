package com.cometchatcalls.cometchatcalls_plugin.wrapper

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.widget.RelativeLayout
import com.cometchat.calls.core.CometChatCalls
import com.cometchat.calls.exceptions.CometChatException
import com.cometchat.calls.listeners.CometChatCallsEventsListener
import com.cometchat.calls.model.AudioMode
import com.cometchat.calls.model.CallSwitchRequestInfo
import com.cometchat.calls.model.MainVideoContainerSetting
import com.cometchat.calls.model.RTCMutedUser
import com.cometchat.calls.model.RTCRecordingInfo
import com.cometchat.calls.model.RTCUser
import com.cometchatcalls.cometchatcalls_plugin.helper.GetMappedObject
import com.cometchatcalls.cometchatcalls_plugin.helper.PluginConstants
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


/**
 * Created by Rohit Giri on 21/03/23.
 */

class CometChatCallsPlatformViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    val TAG = javaClass.simpleName

    companion object{
        lateinit var activity: Activity
        lateinit var call: MethodCall
        lateinit var result: MethodChannel.Result
        lateinit var callsEventsStreamSink: EventChannel.EventSink
        private lateinit var videoContainer: RelativeLayout
        private lateinit var parentContainer: RelativeLayout
        private val uiThreadHandler: Handler = Handler(Looper.getMainLooper())
    }

    fun initVariables(
        activity: Activity,
        call: MethodCall,
        result: MethodChannel.Result,
        callsEventsStreamSink: EventChannel.EventSink
    ){
        CometChatCallsPlatformViewFactory.activity = activity
        CometChatCallsPlatformViewFactory.call = call
        CometChatCallsPlatformViewFactory.result = result
        CometChatCallsPlatformViewFactory.callsEventsStreamSink = callsEventsStreamSink
    }

    fun initCallView() {
        /*parentContainer = RelativeLayout(activity)
        val inflater = LayoutInflater.from(activity)
        val layout = inflater.inflate(R.layout.video_container, null, false) as RelativeLayout
        videoContainer = layout.findViewById(R.id.videoContainer) as RelativeLayout
        parentContainer.addView(layout)*/

        videoContainer = RelativeLayout(activity)

        /*val linearLayout = LinearLayout(activity)
        linearLayout.orientation = LinearLayout.HORIZONTAL
        linearLayout.gravity = Gravity.CENTER
        linearLayout.layoutParams = RelativeLayout.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        val layoutParams2 : RelativeLayout.LayoutParams  = linearLayout.layoutParams as  (RelativeLayout.LayoutParams)
        layoutParams2.addRule(RelativeLayout.CENTER_IN_PARENT)

        val progressBar = ProgressBar(activity)
        progressBar.layoutParams = RelativeLayout.LayoutParams(
            55,
            55
        )
        linearLayout.addView(progressBar)

        val textView = TextView(activity)
        textView.text = "Connecting..."
        textView.setTextColor(Color.parseColor("#FFFFFF"))
        val params: RelativeLayout.LayoutParams = RelativeLayout.LayoutParams(
            ViewGroup.LayoutParams.WRAP_CONTENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        params.setMargins(25, 0, 0, 0)
        textView.layoutParams = params
        linearLayout.addView(textView)

        val defaultBackgroundColor: Int = Color.parseColor("#333333")
        videoContainer.setBackgroundColor(defaultBackgroundColor)
        videoContainer.addView(linearLayout)*/

        val videoSettings = MainVideoContainerSetting()
        videoSettings.setVideoStreamProp(call.argument("videoFit") ?: "contain")
        videoSettings.setfullScreenButtonProps(
            call.argument("fullScreenButtonPosition") ?: "bottom-right",
            call.argument<Boolean>("fullScreenButtonVisibility") ?: true
        )
        videoSettings.setUserListButtonProps(
            call.argument("userListButtonPosition") ?: "bottom-right",
            call.argument<Boolean>("userListButtonVisibility") ?: true
        )
        videoSettings.setZoomButtonProps(
            call.argument("zoomButtonPosition") ?: "bottom-right",
            call.argument<Boolean>("zoomButtonVisibility") ?: true
        )
        videoSettings.setNameLabelProps(
            call.argument("nameLabelPosition") ?: "bottom-left",
            call.argument<Boolean>("nameLabelVisibility") ?: true,
            call.argument("nameLabelColor") ?: "#333333"
        )
        val settings = CometChatCalls.CallSettingsBuilder(activity)
            .setDefaultLayoutEnable(call.argument<Boolean>("defaultLayout") ?: true)
            .setIsAudioOnly(call.argument<Boolean>("isAudioOnly") ?: false)
            .setSingleMode(call.argument<Boolean>("isSingleMode") ?: false)
            .showSwitchToVideoCallButton(call.argument<Boolean>("showSwitchToVideoCall") ?: false)
            .enableVideoTileClick(call.argument<Boolean>("enableVideoTileClick") ?: true)
            .enableVideoTileDrag(call.argument<Boolean>("enableDraggableVideoTile") ?: true)
            .showEndCallButton(call.argument<Boolean>("endCallButtonDisable") ?: false)
            .showRecordingButton(call.argument<Boolean>("showRecordingButton") ?: false)
            .autoRecordOnCallStart(call.argument<Boolean>("startRecordingOnCallStart") ?: false)
            .showSwitchCameraButton(call.argument<Boolean>("switchCameraButtonDisable") ?: false)
            .showMuteAudioButton(call.argument<Boolean>("muteAudioButtonDisable") ?: false)
            .showPauseVideoButton(call.argument<Boolean>("pauseVideoButtonDisable") ?: false)
            .showAudioModeButton(call.argument<Boolean>("audioModeButtonDisable") ?: false)
            .startWithAudioMuted(call.argument<Boolean>("startAudioMuted") ?: false)
            .startWithVideoMuted(call.argument<Boolean>("startVideoMuted") ?: false)
            .setAvatarMode(call.argument<String>("avatarMode") ?: "CIRCLE")
            .setMode(call.argument<String>("mode") ?: "DIRECT")
            .setDefaultAudioMode(call.argument<String>("defaultAudioMode") ?: "SPEAKER")
            .setMainVideoContainerSetting(videoSettings)
            .setEventListener(object : CometChatCallsEventsListener {
                override fun onCallEnded() {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.booleanMap(true, "onCallEnded"))
                    }
                }

                override fun onCallEndButtonPressed() {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.booleanMap(true, "onCallEndButtonPressed"))
                    }
                }

                override fun onUserJoined(p0: RTCUser?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcUserMap(p0, "onUserJoined"))
                    }
                }

                override fun onUserLeft(p0: RTCUser?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcUserMap(p0, "onUserLeft"))
                    }
                }

                override fun onUserListChanged(p0: ArrayList<RTCUser>?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcUserListMap(p0, "onUserListChanged"))
                    }
                }

                override fun onAudioModeChanged(p0: ArrayList<AudioMode>?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.audioModeListMap(p0, "onAudioModeChanged"))
                    }
                }

                override fun onCallSwitchedToVideo(p0: CallSwitchRequestInfo?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.callSwitchRequestInfoMap(p0, "onCallSwitchedToVideo"))
                    }
                }

                override fun onUserMuted(p0: RTCMutedUser?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcMutedUserMap(p0, "onUserMuted"))
                    }
                }

                override fun onRecordingToggled(p0: RTCRecordingInfo?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcRecordingInfoMap(p0, "onRecordingToggled"))
                    }
                }

                override fun onError(p0: CometChatException?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.cometchatExceptionMap(p0, "onError"))
                    }
                }
            })
            .build()

        val callToken: String ?= call.argument<String>(PluginConstants.CometchatCallsStartSessionArgumentsKeys.CALL_TOKEN)

        CometChatCalls.startSession(callToken, settings, videoContainer, object : CometChatCalls.CallbackListener<String>(){
            override fun onSuccess(p0: String) {
                uiThreadHandler.post {
                    result.success(GetMappedObject.stringToMap(p0, PluginConstants.Method.SUCCESS))
                }
            }

            override fun onError(e: CometChatException) {
                uiThreadHandler.post {
                    result.error(e.code, e.message, e.details)
                }
            }
        })
    }

    fun initPresenterCallView() {
        videoContainer = RelativeLayout(activity)

        val presenterSettings = CometChatCalls.PresentationSettingsBuilder(activity)
            .setDefaultLayoutEnable(call.argument<Boolean>("defaultLayout") ?: true)
            .setIsAudioOnly(call.argument<Boolean>("isAudioOnly") ?: false)
            .setSingleMode(call.argument<Boolean>("isSingleMode") ?: false)
            .showEndCallButton(call.argument<Boolean>("endCallButtonDisable") ?: false)
            .showRecordingButton(call.argument<Boolean>("showRecordingButton") ?: false)
            .showSwitchCameraButton(call.argument<Boolean>("switchCameraButtonDisable") ?: false)
            .showMuteAudioButton(call.argument<Boolean>("muteAudioButtonDisable") ?: false)
            .showPauseVideoButton(call.argument<Boolean>("pauseVideoButtonDisable") ?: false)
            .showAudioModeButton(call.argument<Boolean>("audioModeButtonDisable") ?: false)
            .startWithAudioMuted(call.argument<Boolean>("startAudioMuted") ?: false)
            .startWithVideoMuted(call.argument<Boolean>("startVideoMuted") ?: false)
            .setIsPresenter(call.argument<Boolean>("isPresenter") ?: false)
            .setDefaultAudioMode(call.argument<String>("defaultAudioMode") ?: "SPEAKER")
            .setEventListener(object : CometChatCallsEventsListener {
                override fun onCallEnded() {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.booleanMap(true, "onCallEnded"))
                    }
                }

                override fun onCallEndButtonPressed() {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.booleanMap(true, "onCallEndButtonPressed"))
                    }
                }

                override fun onUserJoined(p0: RTCUser?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcUserMap(p0, "onUserJoined"))
                    }
                }

                override fun onUserLeft(p0: RTCUser?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcUserMap(p0, "onUserLeft"))
                    }
                }

                override fun onUserListChanged(p0: ArrayList<RTCUser>?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcUserListMap(p0, "onUserListChanged"))
                    }
                }

                override fun onAudioModeChanged(p0: ArrayList<AudioMode>?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.audioModeListMap(p0, "onAudioModeChanged"))
                    }
                }

                override fun onCallSwitchedToVideo(p0: CallSwitchRequestInfo?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.callSwitchRequestInfoMap(p0, "onCallSwitchedToVideo"))
                    }
                }

                override fun onUserMuted(p0: RTCMutedUser?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcMutedUserMap(p0, "onUserMuted"))
                    }
                }

                override fun onRecordingToggled(p0: RTCRecordingInfo?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.rtcRecordingInfoMap(p0, "onRecordingToggled"))
                    }
                }

                override fun onError(p0: CometChatException?) {
                    uiThreadHandler.post {
                        callsEventsStreamSink.success(GetMappedObject.cometchatExceptionMap(p0, "onError"))
                    }
                }
            })
            .build()

        val callToken: String ?= call.argument<String>(PluginConstants.CometchatCallsStartSessionArgumentsKeys.CALL_TOKEN)

        CometChatCalls.joinPresentation(callToken, presenterSettings, videoContainer, object : CometChatCalls.CallbackListener<String>(){
            override fun onSuccess(p0: String) {
                uiThreadHandler.post {
                    result.success(GetMappedObject.stringToMap(p0, PluginConstants.Method.SUCCESS))
                }
            }

            override fun onError(e: CometChatException) {
                uiThreadHandler.post {
                    result.error(e.code, e.message, e.details)
                }
            }
        })
    }

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return CometChatCallsPlatformView(videoContainer)
        //return CometChatCallsPlatformView(parentContainer)
    }
}