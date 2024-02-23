//
//  Utils.swift
//  cometchat_sdk
//
//  Created by SuryanshBisen on 09/10/23.
//

import Foundation

class Utils {
    
    static let chatSDKName = "cometchat_sdk"
    static let callsSDKName = "cometchat_calls_sdk"
    static let chatUIKitName = "cometchat_chat_uikit"
    static let callsUIKitName = "cometchat_calls_uikit"
    static private var allSDKData: [String: String]?
    
    static func getSDKVersion() -> String {
        if allSDKData == nil {
            allSDKData = getAllSDKs()
        }
        return ((allSDKData?[chatSDKName] as? String) ?? "")
    }
    
    static func getPlatform() -> String {
        return "flutter"
    }
    
    static func getAllSDKs() -> [String: String] {
        
        if allSDKData != nil {
            return allSDKData!
        }
        
        var allInstalledSDK = [String: String]()
        
        let frameworks = Bundle.allFrameworks.filter { (f) -> Bool in
            f.bundleIdentifier?.hasPrefix("com.apple.") == false
        }.sorted { (a, b) -> Bool in
            a.bundleURL.lastPathComponent < b.bundleURL.lastPathComponent
        }
        
        for framework in frameworks {
            let nameToUse = framework.infoDictionary?[kCFBundleNameKey as String] as? String ?? framework.bundleURL.lastPathComponent
            let version = framework.infoDictionary?["CFBundleShortVersionString"] as? String ?? "n/a"
            
            allInstalledSDK[nameToUse] = version
        }
        
        allSDKData = allInstalledSDK
        
        return allInstalledSDK
        
    }
    
}
