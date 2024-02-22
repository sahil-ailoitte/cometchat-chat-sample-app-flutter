class CometChatCallsException implements Exception{
  String code ;
  String? message;
  String? details;

  CometChatCallsException(this.code, this.message, this.details);

  factory CometChatCallsException.fromMap(dynamic map) {
    return CometChatCallsException(
        map['code'],
        map['message'],
        map['details']
    );
  }

  @override
  String toString() {
    return 'CometChatException{code: $code , message $message, details: $details}';
  }
}