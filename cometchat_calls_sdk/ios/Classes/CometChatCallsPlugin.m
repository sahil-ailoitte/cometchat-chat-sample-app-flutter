#import "CometChatCallsPlugin.h"
#if __has_include(<cometchat_calls_sdk/cometchat_calls_sdk-Swift.h>)
#import <cometchat_calls_sdk/cometchat_calls_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cometchat_calls_sdk-Swift.h"
#endif

@implementation CometChatCallsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCometchatcallsPlugin registerWithRegistrar:registrar];
}
@end
