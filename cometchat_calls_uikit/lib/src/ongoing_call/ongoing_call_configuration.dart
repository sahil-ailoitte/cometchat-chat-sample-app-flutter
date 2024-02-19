import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

/// [OngoingCallConfiguration] is a data class that has configuration properties for  [CometChatOngoingCallScreen]
///
/// ```dart
/// OngoingCallConfiguration(
/// callSettingsBuilder: CallSettingsBuilder(),
/// onError: (CometChatException exception) {
/// print('Error: ${exception.errorDescription}');
/// },
/// );
///
class OngoingCallConfiguration {
  OngoingCallConfiguration({this.callSettingsBuilder, this.onError});

  /// [callSettingsBuilder] is used to set a custom call settings
  final CallSettingsBuilder? callSettingsBuilder;

  /// [onError] is called when some error occurs
  final OnError? onError;
}