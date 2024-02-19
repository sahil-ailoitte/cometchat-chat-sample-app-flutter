import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

class CallingConfiguration {

  CallingConfiguration(
      {this.outgoingCallConfiguration,
        this.incomingCallConfiguration,
        this.callButtonsConfiguration,
      this.callBubbleConfiguration,
        this.ongoingCallConfiguration
      });

 ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
final OutgoingCallConfiguration? outgoingCallConfiguration;

///[incomingCallConfiguration] is a object of [IncomingCallConfiguration] which sets the configuration for incoming call
final IncomingCallConfiguration? incomingCallConfiguration;

///[callButtonsConfiguration] is a object of [CallButtonsConfiguration] which sets the configuration for call buttons
final CallButtonsConfiguration? callButtonsConfiguration;

///[callBubbleConfiguration] is a object of [CallBubbleConfiguration] which sets the configuration for call bubble
final CallBubbleConfiguration? callBubbleConfiguration;

  ///[ongoingCallConfiguration] is used to define the configuration for ongoing call screen.
  final OngoingCallConfiguration? ongoingCallConfiguration;
}