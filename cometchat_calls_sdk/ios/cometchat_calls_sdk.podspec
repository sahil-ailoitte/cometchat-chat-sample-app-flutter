#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cometchatcalls_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cometchat_calls_sdk'
  s.version          = '4.0.2'
  s.summary          = 'CometChat Calls Flutter Plugin'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://www.cometchat.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'rohit.giri@cometchat.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'CometChatCallsSDK', '4.0.2'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
