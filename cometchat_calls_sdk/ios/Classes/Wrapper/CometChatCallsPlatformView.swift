import Flutter
import UIKit
import CometChatCallsSDK

class CometChatCallsPlatformView: NSObject, FlutterPlatformView {
    
    private var _view: UIView
        
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, view: UIView) {
        
        _view = view
        super.init()
        
    }
    
    func view() -> UIView {
        return _view
    }
}
