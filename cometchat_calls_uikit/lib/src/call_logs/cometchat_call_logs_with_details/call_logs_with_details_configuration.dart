import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CallLogsWithDetailsConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [CometChatCallLogsWithDetails]
///```dart
/// CallLogsWithDetailsConfiguration(
/// callLogDetailConfiguration: CallLogDetailsConfiguration(),
/// callLogsConfiguration: CallLogsConfiguration(),
/// )
/// ```
///
class CallLogsWithDetailsConfiguration {
  CallLogsWithDetailsConfiguration({
    this.callLogDetailConfiguration,
    this.theme,
    this.callLogsConfiguration,
  });

  ///[callLogsConfiguration] used to set the configuration properties of [CometChatCallLogs]
  final CallLogsConfiguration? callLogsConfiguration;

  ///[callLogDetailConfiguration] used to set the configuration properties of [CometChatCallLogDetails]
  final CallLogDetailsConfiguration? callLogDetailConfiguration;

  ///[theme] can pass custom theme
  final CometChatTheme? theme;
}
