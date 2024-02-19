import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';

class CometChatCallLogHistoryController
    extends CometChatListController<CallLog, String> {
  CometChatCallLogHistoryController(
      {required this.callLogsBuilderProtocol, OnError? onError})
      : super(callLogsBuilderProtocol.getRequest(), onError: onError);

  late CallLogsBuilderProtocol callLogsBuilderProtocol;

  User? loggedInUser;
  String? authToken;

  List<CallLog> sortedCallLogsList = [];

  CallLog? lastElement;

  Map<String, List<CallLog>> groupedEntries = {};

  @override
  void onInit() {
    super.onInit();
    _initializeLoggedInUser();
  }


  _initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
    update();
  }

  @override
  loadMoreElements({bool Function(CallLog element)? isIncluded}) async {
    isLoading = true;
    loggedInUser ??= await CometChat.getLoggedInUser();
    try {
      await request.fetchNext(onSuccess: (List<CallLog> fetchedList) {
        if (fetchedList.isEmpty) {
          isLoading = false;
          hasMoreItems = false;
        } else {
          isLoading = false;
          hasMoreItems = true;
          for (var element in fetchedList) {
            final date = element.initiatedAt;
            if (!groupedEntries
                .containsKey(CallLogsUtils.storeValueInMapTime(date))) {
              groupedEntries[CallLogsUtils.storeValueInMapTime(date)] = [];
            }
            groupedEntries[CallLogsUtils.storeValueInMapTime(date)]!
                .add(element);
            if (isIncluded != null && isIncluded(element) == true) {
              list.add(element);
            } else {
              list.add(element);
            }
          }
        }
        update();
      }, onError: (CometChatCallsException e) {
        if (kDebugMode) {
          debugPrint("Error -> ${e.details}");
        }
        if (onError != null) {
          onError!(e);
        } else {
          error = e;
          hasError = true;
        }

        update();
      });
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint("Error in Catch  -> $e");
      }
      error = CometChatCallsException("ERR", s.toString(), "Error");
      hasError = true;
      isLoading = false;
      hasMoreItems = false;
      update();
    }
  }

  @override
  String getKey(CallLog element) {
    return element.mid ?? "";
  }

  @override
  bool match(CallLog elementA, CallLog elementB) {
    return elementA.sessionId == elementB.sessionId;
  }
}
