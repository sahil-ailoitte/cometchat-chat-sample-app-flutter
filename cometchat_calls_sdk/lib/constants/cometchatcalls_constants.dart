class CometChatCallsConstants{
  ///SuccessMessages

  ///Errors

  ///Code
  /// These constants are used to represent the error codes and messages that can be returned by the CometChatCalls SDK.
  /// Error Codes
  static const String codeError = "ERROR";
  static const String codeCometChatCallsSDKInitError = "COMETCHATCALLS_SDK_INIT_ERROR";
  static const String codeSessionIdNull = "SESSION_ID_NULL";
  static const String codeUserAuthTokenNull = "USER_AUTH_TOKEN_NULL";
  /// Messages
  static const String messageCometChatCallsSDKInit = "CometChatCalls SDK is not initialized, requested result is null";
  static const String messageCodeUserAuthTokenNull = "User auth token is null";
  static const String messageCodeUserAuthTokenBlankOrEmpty = "User auth token is empty or blank";


  ///Calling
  /// The `CALL_STATUS_CANCELLED` constant is used to indicate that the call has been cancelled.
  static const String callStatusCancelled = "cancelled";

  /// The `CALL_STATUS_REJECTED` constant is used to indicate that the call has been rejected.
  static const String callStatusRejected = "rejected";

  /// The circle avatar mode.
  static const String avatarModeCircle = 'circle';

  /// The square avatar mode.
  static const String avatarModeSquare = 'square';

  /// The fullscreen avatar mode.
  static const String avatarModeFullScreen = 'fullscreen';

  /// The spotlight mode.
  static const String modeSpotlight = 'SPOTLIGHT';

  /// The single mode.
  static const String modeSingle = 'SINGLE';

  /// The default mode.
  static const String modeDefault = 'DEFAULT';

  /// The contain aspect ratio.
  static const String aspectRatioContain = 'contain';

  /// The cover aspect ratio.
  static const String aspectRatioCover = 'cover';

  /// The default aspect ratio.
  static const String aspectRatioDefault = 'default';

  /// The top-right position.
  static const String positionTopRight = 'top-right';

  /// The top-left position.
  static const String positionTopLeft = 'top-left';

  /// The bottom-right position.
  static const String positionBottomRight = 'bottom-right';

  /// The bottom-left position.
  static const String positionBottomLeft = 'bottom-left';

  ///Call Log Constants
  /// Session ID of the call
  static const String sessionId = "sessionId";

  /// Total audio minutes of the call
  static const String totalAudioMinutes = "totalAudioMinutes";

  /// Total video minutes of the call
  static const String totalVideoMinutes = "totalVideoMinutes";

  /// Total duration of the call
  static const String totalDuration = "totalDuration";

  /// Determines if the call has a recording
  static const String hasRecording = "hasRecording";

  /// Timestamp when the call was initiated
  static const String initiatedAt = "initiatedAt";

  /// Timestamp when the call was ended
  static const String endedAt = "endedAt";

  /// Mode of the call (audio or video)
  static const String mode = "mode";

  /// Type of the receiver (user, group, etc.)
  static const String receiverType = "receiverType";

  /// Total duration of the call in minutes
  static const String totalDurationInMinutes = "totalDurationInMinutes";

  /// Total participants in the call
  static const String totalParticipants = "totalParticipants";

  /// Message ID of the call
  static const String mid = "mid";

  /// Type of the call (incoming, outgoing, missed)
  static const String type = "type";

  /// Status of the call
  static const String status = "status";

  /// List of participants in the call
  static const String participants = "participants";

  /// List of recordings of the call
  static const String recordings = "recordings";

  /// Initiator of the call
  static const String initiator = "initiator";

  /// Receiver of the call
  static const String receiver = "receiver";

  /// Receiver type User
  static const String receiverTypeUser = "user";

  /// Receiver type Group
  static const String receiverTypeGroup = "group";

  /// Call category
  static const String callCategoryCall = "call";

}