import 'package:cometchat_sdk/models/message_reaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Exception/CometChatException.dart';
import '../utils/constants.dart';

class ReactionRequest {
  final int? maxLimit = 100;
  final int? defaultLimit = 30;

  String? key;
  int limit = 30;
  int? messageId = 0;
  String? reaction;

  ReactionRequest._builder(ReactionRequestBuilder builder)
      : limit = builder.limit,
        messageId = builder.messageId,
        reaction = builder.reaction;


  /// Asynchronously fetches the next set of reactions for a particular message.
  ///
  /// This function will invoke the 'fetchNextMessageRequest' method on the platform-specific implementation,
  /// passing the limit, messageId, and reaction as parameters.
  /// The limit parameter defines the maximum number of message reactions to fetch.
  /// The messageId parameter specifies the ID of the message for which reactions are to be fetched.
  /// The reaction parameter specifies the reaction to filter with.
  ///
  /// Upon success, the function will convert the result into a list of MessageReaction objects and call the onSuccess callback with this list.
  /// If an exception occurs during the fetch operation or the conversion of the result, the onError callback will be called with a CometChatException.
  ///
  /// @param onSuccess A callback function which is called when the function successfully fetches the next set of reactions. This function is passed the list of fetched MessageReaction objects.
  /// @param onError A callback function which is called when an exception occurs during the fetch operation or the conversion of the result. This function is passed a CometChatException detailing the error.
  /// @return A Future that completes with a list of MessageReaction objects. If an error occurs, the future completes with an empty list.
  ///
  Future<List<MessageReaction>> fetchNext({required Function(List<MessageReaction> message)? onSuccess, required Function(CometChatException excep)? onError}) async {
    try{
      final result = await channel.invokeMethod('fetchNextReactionRequest', {
        'limit': this.limit,
        'messageId': this.messageId,
        'reaction': this.reaction,
        'key': this.key
      });
      final List<MessageReaction> res = [];
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            res.add(MessageReaction.fromMap(_obj));
          }
        }
      }
      if(onSuccess != null) onSuccess(res);
      return res;
    } on PlatformException catch (platformException) {
      if(onError != null) onError(CometChatException(platformException.code, platformException.details, platformException.message));
    } catch (e) {
      debugPrint("Error: $e");
      if(onError != null) onError(CometChatException(ErrorCode.errorUnhandledException, e.toString() , e.toString()));
    }
    return [];
  }

  /// Asynchronously fetches the previous set of reactions for a specific message.
  ///
  /// This method invokes the 'fetchNextMessageRequest' method on the platform-specific implementation,
  /// with 'limit', 'messageId', and 'reaction' passed as parameters.
  /// The 'limit' parameter defines the max number of message reactions to be fetched.
  /// The 'messageId' specifies the ID of the message for which the reactions are fetched.
  /// The 'reaction' parameter specifies the reaction to be used for filtering.
  ///
  /// If successful, this function will convert the result into a list of MessageReaction objects and will call the onSuccess callback with this list.
  /// If an exception is thrown during the fetch operation or during the conversion of the result, onError callback will be invoked with a CometChatException.
  ///
  /// @param onSuccess A callback function to be invoked upon the successful fetching of previous reactions. This function receives a list of fetched MessageReaction objects as a parameter.
  /// @param onError A callback function to be invoked when an exception is thrown during the fetch operation or the conversion of the result. This function will receive a CometChatException that details the error.
  /// @return A Future that completes with a list of MessageReaction objects. If an error is encountered, the future completes with an empty list.
  ///
  Future<List<MessageReaction>> fetchPrevious({required Function(List<MessageReaction> message)? onSuccess, required Function(CometChatException excep)? onError}) async {
    try{
      final result = await channel.invokeMethod('fetchPreviousReactionRequest', {
        'limit': this.limit,
        'messageId': this.messageId,
        'reaction': this.reaction,
        'key': this.key
      });
      final List<MessageReaction> res = [];
      if (result != null) {
        key = result["key"];
        if (result["list"] != null) {
          for (var _obj in result["list"]) {
            res.add(MessageReaction.fromMap(_obj));
          }
        }
      }
      if(onSuccess != null) onSuccess(res);
      return res;
    } on PlatformException catch (platformException) {
      if(onError != null) onError(CometChatException(platformException.code, platformException.details, platformException.message));
    } catch (e) {
      debugPrint("Error: $e");
      if(onError != null) onError(CometChatException(ErrorCode.errorUnhandledException, e.toString() , e.toString()));
    }
    return [];
  }
}

class ReactionRequestBuilder {
  int limit = 30;
  int? messageId = -1;
  String? reaction;

  ReactionRequestBuilder();

  ReactionRequest build() {
    return ReactionRequest._builder(this);
  }
}
