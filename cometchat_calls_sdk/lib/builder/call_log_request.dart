import 'dart:convert';

import 'package:cometchat_calls_sdk/cometchat_calls_sdk.dart';

import '../helper/api_connection.dart';
import '../helper/cometchatcalls_utils.dart';
import '../model/call_log_filter_params.dart';

/// Created by Rohit Giri on 22/03/23.
class CallLogRequest{
  final _tag = "CallLogRequest";

  String? callType;
  String? callStatus;
  String? callCategory;
  String? callDirection;
  String? uid;
  String? guid;
  String? authToken;
  bool hasRecording = false;

  //Pagination
  int totalPages = 0;
  int currentPage = 0;
  int maxLimit = 100;
  int limit = 30;
  int defaultLimit = 30;

  CallLogRequest._builder(CallLogRequestBuilder builder):
        callType = builder.callType,
        callStatus = builder.callStatus,
        callCategory = builder.callCategory,
        callDirection = builder.callDirection,
        uid = builder.uid,
        guid = builder.guid,
        authToken = builder.authToken,
        limit = builder.limit,
        hasRecording = builder.hasRecording;

  /// Fetches the next batch of call logs.
  ///
  /// The [onSuccess] function is called with a list of [CallLog] objects when the call logs are successfully fetched.
  /// The [onError] function is called with a [CometChatCallsException] object when there is an error while fetching the call logs.
  ///
  /// Returns a [Future] that resolves to a list of [CallLog] objects.
  ///
  /// Example:
  /// ```dart
  /// fetchNext(
  ///   onSuccess: (callLogs) {
  ///     // Process the fetched call logs
  ///   },
  ///   onError: (exception) {
  ///     // Handle the error
  ///   },
  /// );
  /// ```
  Future<List<CallLog>> fetchNext({required Function(List<CallLog> callLogs) onSuccess, required Function(CometChatCallsException excep) onError}) async{
    if (!await CometChatCalls.isInitialized()) {
      onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, CometChatCallsConstants.messageCometChatCallsSDKInit, CometChatCallsConstants.messageCometChatCallsSDKInit));
    } else if(authToken == null){
      onError(CometChatCallsException(CometChatCallsConstants.codeUserAuthTokenNull, CometChatCallsConstants.messageCodeUserAuthTokenNull, CometChatCallsConstants.messageCodeUserAuthTokenNull));
    } else if(authToken!.isEmpty){
      onError(CometChatCallsException(CometChatCallsConstants.codeUserAuthTokenNull, CometChatCallsConstants.messageCodeUserAuthTokenBlankOrEmpty, CometChatCallsConstants.messageCodeUserAuthTokenBlankOrEmpty));
    }
    if(totalPages != 0 && totalPages == currentPage ){
      onSuccess(<CallLog>[]);
      return [];
    }
    ApiConnection().getCallLogList(getParams(true), authToken!, (String response){
      getCallLogList(onSuccess, onError, response);
    }, (CometChatCallsException e){
      CometChatCallsUtils.showLog(_tag, "generateToken onError: ${e.message}");
      onError(e);
    });
    return [];
  }

  /// Fetches the previous batch of call logs.
  ///
  /// The [onSuccess] function is called with a list of [CallLog] objects when the call logs are successfully fetched.
  /// The [onError] function is called with a [CometChatCallsException] object when there is an error while fetching the call logs.
  ///
  /// Returns a [Future] that resolves to a list of [CallLog] objects.
  ///
  /// Example:
  /// ```dart
  /// fetchPrevious(
  ///   onSuccess: (callLogs) {
  ///     // Process the fetched call logs
  ///   },
  ///   onError: (exception) {
  ///     // Handle the error
  ///   },
  /// );
  /// ```
  Future<List<CallLog>> fetchPrevious({required Function(List<CallLog> callLogs) onSuccess, required Function(CometChatCallsException excep) onError}) async{
    if (!await CometChatCalls.isInitialized()) {
      onError(CometChatCallsException(CometChatCallsConstants.codeCometChatCallsSDKInitError, CometChatCallsConstants.messageCometChatCallsSDKInit, CometChatCallsConstants.messageCometChatCallsSDKInit));
    } else if(authToken == null){
      onError(CometChatCallsException(CometChatCallsConstants.codeUserAuthTokenNull, CometChatCallsConstants.messageCodeUserAuthTokenNull, CometChatCallsConstants.messageCodeUserAuthTokenNull));
    } else if(authToken!.isEmpty){
      onError(CometChatCallsException(CometChatCallsConstants.codeUserAuthTokenNull, CometChatCallsConstants.messageCodeUserAuthTokenBlankOrEmpty, CometChatCallsConstants.messageCodeUserAuthTokenBlankOrEmpty));
    }
    if(currentPage == 1) {
      onSuccess(<CallLog>[]);
      return [];
    }
    ApiConnection().getCallLogList(getParams(false), authToken!, (String response){
      getCallLogList(onSuccess, onError, response);
    }, (CometChatCallsException e){
      CometChatCallsUtils.showLog(_tag, "generateToken onError: ${e.message}");
      onError(e);
    });
    return [];
  }

  getCallLogList(Function(List<CallLog> callLogs) onSuccess, Function(CometChatCallsException excep) onError, String response) {
    List<CallLog> data = <CallLog>[];
    try{
      totalPages = jsonDecode(response)['meta']['pagination']["total_pages"];
      currentPage = jsonDecode(response)['meta']['pagination']["current_page"];
      if (jsonDecode(response)["data"] != null) {
        data = <CallLog>[];
        jsonDecode(response)["data"].forEach((v) {
          data.add(CallLog.fromJson(v));
        });
        onSuccess(data);
      }
    }catch (e) {
      CometChatCallsUtils.showLog(_tag, "Error: $e");
      onError(CometChatCallsException(CometChatCallsConstants.codeError, e.toString(), e.toString()));
    }
  }

  CallLogFilterParams getParams(bool isNext) {
    final params = CallLogFilterParams();
    if (isNext) {
      params.page = currentPage + 1;
    } else {
      params.page = currentPage - 1;
    }
    params.perPage = limit;
    params.hasRecordings = hasRecording;
    if(callStatus != null && callStatus!.isNotEmpty){
      params.status = callStatus;
    }
    if (callType != null && callType!.isNotEmpty) {
      params.type = callType;
    }
    if (callCategory != null && callCategory!.isNotEmpty) {
      params.mode = callCategory;
    }
    if (callDirection != null && callDirection!.isNotEmpty) {
      params.direction = callDirection;
    }
    if (uid != null && uid!.isNotEmpty) {
      params.uid = uid;
    }
    if (guid != null && guid!.isNotEmpty) {
      params.guid = guid;
    }
    return params;
  }

}

class CallLogRequestBuilder {
  String? callType;
  String? callStatus;
  String? callCategory;
  String? callDirection;
  String? uid;
  String? guid;
  String? authToken;
  bool hasRecording = false;

  //Pagination
  int limit = 30;

  CallLogRequestBuilder();

  CallLogRequest build() {
    return CallLogRequest._builder(this);
  }
}