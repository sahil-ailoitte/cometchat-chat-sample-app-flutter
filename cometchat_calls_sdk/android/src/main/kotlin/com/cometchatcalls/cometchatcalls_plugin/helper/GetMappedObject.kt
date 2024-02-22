package com.cometchatcalls.cometchatcalls_plugin.helper

import com.cometchat.calls.model.*

/**
 * Created by Rohit Giri on 22/03/23.
 */
object GetMappedObject {
    fun rtcUserListMap(
        rtcUserList: ArrayList<RTCUser>?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (rtcUserList == null) return null
        if (rtcUserList.isEmpty()) return null
        return hashMapOf(
            "methodName" to methodName,
            "userList" to rtcUserList.map { e ->  rtcUserMap(e) }
        )
    }

    fun rtcUserMap(
        rtcUser: RTCUser?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (rtcUser == null) return null
        return hashMapOf(
            "uid" to rtcUser.uid,
            "name" to rtcUser.name,
            "avatar" to rtcUser.avatar,
            "jwt" to rtcUser.jwt,
            "resource" to rtcUser.resource,
            "methodName" to methodName
        )
    }

    fun audioModeListMap(
        audioModeList: ArrayList<AudioMode>?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (audioModeList == null) return null
        if (audioModeList.isEmpty()) return null
        return hashMapOf(
            "methodName" to methodName,
            "audioModeList" to audioModeList.map { e ->  audioModeMap(e) }
        )
    }

    fun audioModeMap(
        audioMode: AudioMode?,
    ): HashMap<String, Any?>? {
        if (audioMode == null) return null
        return hashMapOf(
            "mode" to audioMode.mode,
            "isSelected" to audioMode.isSelected
        )
    }

    fun callSwitchRequestInfoMap(
        callSwitchRequestInfo: CallSwitchRequestInfo?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (callSwitchRequestInfo == null) return null
        return hashMapOf(
            "sessionId" to callSwitchRequestInfo.sessionId,
            "requestInitiatedBy" to rtcUserMap(callSwitchRequestInfo.requestInitiatedBy),
            "requestAcceptedBy" to rtcUserMap(callSwitchRequestInfo.requestAcceptedBy),
            "methodName" to methodName
        )
    }

    fun rtcMutedUserMap(
        rtcMutedUser: RTCMutedUser?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (rtcMutedUser == null) return null
        return hashMapOf(
            "muted" to rtcUserMap(rtcMutedUser.muted),
            "mutedBy" to rtcUserMap(rtcMutedUser.mutedBy),
            "methodName" to methodName
        )
    }

    fun rtcRecordingInfoMap(
        rtcRecordingInfo: RTCRecordingInfo?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (rtcRecordingInfo == null) return null
        return hashMapOf(
            "recordingStarted" to rtcRecordingInfo.recordingStarted,
            "user" to rtcUserMap(rtcRecordingInfo.user),
            "methodName" to methodName
        )
    }

    fun cometchatExceptionMap(
        cometchatException: com.cometchat.calls.exceptions.CometChatException?,
        methodName: String = ""
    ): HashMap<String, Any?>? {
        if (cometchatException == null) return null
        return hashMapOf(
            "code" to cometchatException.code,
            "message" to cometchatException.message,
            "localizedMessage" to cometchatException.localizedMessage,
            "details" to cometchatException.details,
            "methodName" to methodName
        )
    }

    fun booleanMap(
        flag: Boolean,
        methodName: String = ""
    ): HashMap<String, Any?> {
        return hashMapOf(
            "code" to flag,
            "methodName" to methodName
        )
    }

    fun stringToMap(
        message: String = "",
        methodName: String = ""
    ): HashMap<String, Any?> {
        return hashMapOf(
            "message" to message,
            "methodName" to methodName
        )
    }

    fun successMap(
        msg: String,
        methodName: String
    ): HashMap<String, Any> {
        return hashMapOf(
            "message" to msg,
            "methodName" to methodName
        )
    }

}