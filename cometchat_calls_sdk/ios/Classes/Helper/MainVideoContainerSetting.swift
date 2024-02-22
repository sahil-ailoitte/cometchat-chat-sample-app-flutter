
import Foundation


class MainVideoContainerSetting: NSObject {
    private var aspectRatio: String? = PluginConstants.AspectRatio.DEFAULT.value
    private var dictionaryForVideoSetting = NSMutableDictionary()
    private var dictionaryForNameLabelPosition = NSMutableDictionary()
    private var dictionaryForFullScreenButtonPosition = NSMutableDictionary()
    private var dictionaryForZoomButtonPosition = NSMutableDictionary()
    private var dictionaryUserListButtonPosition = NSMutableDictionary()
    
    override public init() {
        dictionaryForNameLabelPosition.setValue(true, forKey: "visibility")
        dictionaryForNameLabelPosition.setValue(PluginConstants.Position.BOTTOM_LEFT.value, forKey: "position")
        dictionaryForNameLabelPosition.setValue("#333333", forKey: "color")
        
        dictionaryForFullScreenButtonPosition.setValue(true, forKey: "visibility")
        dictionaryForFullScreenButtonPosition.setValue(PluginConstants.Position.BOTTOM_RIGHT.value, forKey: "position")
        
        dictionaryForZoomButtonPosition.setValue(true, forKey: "visibility")
        dictionaryForZoomButtonPosition.setValue(PluginConstants.Position.BOTTOM_RIGHT.value, forKey: "position")
        
        dictionaryUserListButtonPosition.setValue(true, forKey: "visibility")
        dictionaryUserListButtonPosition.setValue(PluginConstants.Position.BOTTOM_RIGHT.value, forKey: "position")
    }
    
    public func getDictionaryForVideoSetting() -> NSMutableDictionary {
        self.dictionaryForVideoSetting.setValue(aspectRatio, forKey: "videoFit")
        self.dictionaryForVideoSetting.setValue(dictionaryForNameLabelPosition, forKey: "nameLabel")
        self.dictionaryForVideoSetting.setValue(dictionaryForFullScreenButtonPosition, forKey: "fullScreenButton")
        self.dictionaryForVideoSetting.setValue(dictionaryForZoomButtonPosition, forKey: "zoomButton")
        self.dictionaryForVideoSetting.setValue(dictionaryUserListButtonPosition, forKey: "userListButton")
        return self.dictionaryForVideoSetting
    }
    
    public func setMainVideoAspectRatio(_ aspectRatio: String?) {
        self.aspectRatio = aspectRatio
    }
    
    public func setNameLabelParams(_ visibility:Bool, _ position: String?, _ backGroundColor:String?) {
        self.dictionaryForNameLabelPosition.setValue(visibility, forKey: "visibility")
        if let position = position {
            self.dictionaryForNameLabelPosition.setValue(position, forKey: "position")
        }
        if let backGroundColor = backGroundColor {
            self.dictionaryForNameLabelPosition.setValue(backGroundColor, forKey: "color")
        }
    }
    
    public func setFullScreenButtonParams(_ visibility:Bool, _ position: String?) {
        self.dictionaryForFullScreenButtonPosition.setValue(visibility, forKey: "visibility")
        if let position = position {
            self.dictionaryForFullScreenButtonPosition.setValue(position, forKey: "position")
        }
    }
    
    public func setZoomButtonParams(_ visibility:Bool, _ position: String?) {
        self.dictionaryForZoomButtonPosition.setValue(visibility, forKey: "visibility")
        if let position = position {
            self.dictionaryForZoomButtonPosition.setValue(position, forKey: "position")
        }
    }
    
    public func setUserListButtonParams(_ visibility:Bool, _ position: String?) {
        self.dictionaryUserListButtonPosition.setValue(visibility, forKey: "visibility")
        if let position = position {
            self.dictionaryUserListButtonPosition.setValue(position, forKey: "position")
        }
    }
    
    
}
