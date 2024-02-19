## 4.1.0 - 14th December 2023

### Added
- New components : `CometChatCallLogs`, `CometChatCallLogsWithDetails`, `CometChatCallLogRecordings`, `CometChatCallLogParticipants`, `CometChatCallLogHistory` , `CometChatCallLogDetails`
- Models: `CometChatCallLogDetailsOption`, `CometChatCallLogDetailsTemplate`

### Changed

- [cometchat_calls_sdk](https://pub.dev/packages/cometchat_calls_sdk) dependency upgraded to `cometchat_calls_sdk: ^4.0.2`
- [cometchat_sdk](https://pub.dev/packages/cometchat_sdk) dependency upgraded to `cometchat_sdk: ^4.0.4`
- [cometchat_uikit_shared](https://pub.dev/packages/cometchat_uikit_shared) dependency upgraded to `cometchat_uikit_shared: ^4.1.0`

## 4.0.1 - 17th October 2023

### Fixed
- Issue with ending a user to user call

### Changed

- [cometchat_calls_sdk](https://pub.dev/packages/cometchat_calls_sdk) dependency upgraded to `cometchat_calls_sdk: ^4.0.1`
- [cometchat_sdk](https://pub.dev/packages/cometchat_sdk) dependency upgraded to `cometchat_sdk: ^4.0.2`
- [cometchat_uikit_shared](https://pub.dev/packages/cometchat_uikit_shared) dependency upgraded to `cometchat_uikit_shared: ^4.0.2`


## 4.0.0 - 5th September 2023

### Added

- `CometChatCallingExtension` conforms to the updated `ExtensionsDataSource` class by implementing new methods `addExtension` and `getExtensionId`.
- properties introduced in `CallBubbleStyle` to configure height, width, background color, border and border radius and join call button background of `CometChatCallBubble`


### Changed

- [cometchat_sdk](https://pub.dev/packages/cometchat_sdk) dependency upgraded to `cometchat_sdk: ^4.0.1`
- [cometchat_uikit_shared](https://pub.dev/packages/cometchat_uikit_shared) dependency upgraded to `cometchat_uikit_shared: ^4.0.1`
- [GetX](https://pub.dev/packages/get) dependency upgraded to `get: ^4.6.5`
- replaced implementation of `SoundManager` with `CometChatUIKit.soundManager`.
- end call flow of `CometChatOngoingCall` updated
- `CometChatIncomingCall` will now display if the call is a audio call or video call

### Removed

- unused imports
- dead code


## 4.0.0-beta.1 - 7th August 2023

*  🎉 first release!

