import Foundation
import CometChatCallsSDK

class GetMappedObject {

    static func boolMap(
        flag: Bool,
        methodName: String
    ) -> [String: Any?] {
        return [
            "flag": flag,
            "methodName": methodName
        ]
    }
    
    static func rtcUserMap(
        rtcUser: NSDictionary,
        methodName: String = ""
    ) -> [String: Any?]{
        return [
            "uid": rtcUser["uid"],
            "name": rtcUser["name"],
            "avatar": rtcUser["avatar"],
            "jwt": rtcUser["jwt"],
            "resource": rtcUser["resource"],
            "methodName": methodName
        ]
    }
    
    static func rtcUserListMap(
        rtcUserList: NSArray,
        methodName: String = ""
    ) -> [String: Any?] {
        
        var userList: [Any?] = []
        rtcUserList.forEach { e in
            userList.append(rtcUserMap(rtcUser: e as! NSDictionary))
        }
        
        print(["userList": userList])
        
        return [
            "methodName": methodName,
            "userList": userList
        ]
    }
    
    static func audioModeMap(
        audioMode: NSDictionary?,
        methodName: String = ""
    ) -> [String: Any?]? {
        if audioMode == nil {
            print("iOS GetMappedObject audioModeMap: audioMode found null")
            return nil
        }
        return [
            "mode": audioMode!["mode"],
            "isSelected": audioMode!["isSelected"]
        ]
    }
    
    static func audioModeListMap(
        audioModeList: NSArray?,
        methodName: String = ""
    ) -> [String: Any?]? {
        
        if audioModeList == nil {
            print("iOS GetMappedObject audioModeListMap: audioModeList found null")
            return nil
        }
        
        var audioModeArray: [Any] = []
        audioModeList?.forEach({ e in
            audioModeArray.append(audioModeMap(audioMode: e as? NSDictionary))
        })
        
        return [
            "methodName": methodName,
            "audioModeList": audioModeArray
        ]
        
    }
    
    static func callSwitchRequestInfoMap(
        callSwitchRequestInfo: NSDictionary?,
        methodName: String
    ) -> [String: Any?]? {
        if callSwitchRequestInfo == nil {
            print("iOS GetMappedObject callSwitchRequestInfoMap: callSwitchRequestInfo found null")
            return nil
        }
        return [
            "sessionId": callSwitchRequestInfo!["sessionId"],
            "requestInitiatedBy": callSwitchRequestInfo!["requestInitiatedBy"],
            "requestAcceptedBy": callSwitchRequestInfo!["requestAcceptedBy"],
            "methodName": callSwitchRequestInfo!["methodName"]
        ]
    }
    
    static func rtcRecordingInfoMap (
        rtcRecordingInfo: NSDictionary?,
        methodName: String
    ) -> [String: Any?]? {
        
        guard let rtcRecordingInfo = rtcRecordingInfo else {
            print("iOS GetMappedObject rtcRecordingInfoMap: rtcRecordingInfo found null")
            return nil
        }
        
        return [
            "recordingStarted": rtcRecordingInfo["rtcRecordingInfo"],
            "user": rtcUserMap(rtcUser: rtcRecordingInfo["user"] as! NSDictionary),
            "methodName": methodName
        ]
    }
    
    static func rtcMutedUserMap (
        rtcMutedUser: NSDictionary?,
        methodName: String
    ) -> [String: Any?]? {
        
        guard let rtcMutedUser = rtcMutedUser else {
            print("iOS GetMappedObject rtcMutedUserMap: rtcMutedUser found null")
            return nil
        }
        
        return [
            "muted": rtcUserMap(rtcUser: rtcMutedUser["muted"] as! NSDictionary),
            "mutedBy": rtcUserMap(rtcUser: rtcMutedUser["mutedBy"] as! NSDictionary),
            "methodName": methodName
        ]
    }
    
    static func cometchatExceptionMap (
        code: String,
        message: String,
        localizedMessage: String,
        details: String,
        methodName: String
    ) -> [String: Any?] {
        return [
            "code": code,
            "message": message,
            "localizedMessage": localizedMessage,
            "details": details,
            "methodName": methodName
        ]
    }
    
    static func resultMap (
        msg: String?,
        methodName: String?
    ) -> [String: Any?] {
        return [
            "message": msg,
            "methodName": methodName
        ]
    }
    
}
