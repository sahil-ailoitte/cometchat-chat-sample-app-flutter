import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallLogsUtils {
  // This will return the date separator title eg: Today, yesterday...
  static Widget getDateTimeTitle(
      CometChatTheme theme,
      Map<String, List<CallLog>> groupedEntries,
      int index,
      String? dateSeparatorPattern,
      TextStyle? customStyle,
      BuildContext context) {
    String? date = groupedEntries.keys.elementAt(index);

    DateFormat format = DateFormat("dd MMM yyyy");

    DateTime dateTime = DateTime.now();
    try {
      dateTime = format.parse(date);
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Error parsing date string: $e");
      }
      return const SizedBox();
    }

    return CometChatDate(
      date: dateTime,
      pattern: DateTimePattern.dayDateFormat,
      customDateString: dateSeparatorPattern,
      style: DateStyle(
        background: theme.palette.getBackground(),
        textStyle: customStyle ??
            TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: theme.typography.name.fontSize,
              fontWeight: theme.typography.title1.fontWeight,
              color: theme.palette.getAccent(),
            ),
        border: Border.all(
          color: theme.palette.getBackground(),
          width: 0,
        ),
      ),
    );
  }

  // Used to convert the date when there is epoch time as input
  static Widget getTime(
    CometChatTheme theme,
    TextStyle? customStyle,
    BuildContext context,
    int? epochTimestampInSeconds, {
    bool needYear = false,
    String? datePattern,
  }) {
    if (epochTimestampInSeconds != null) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(epochTimestampInSeconds * 1000);

      return CometChatDate(
        date: dateTime,
        pattern: (needYear == true)
            ? DateTimePattern.dayDateFormat
            : DateTimePattern.timeFormat,
        customDateString: datePattern,
        style: DateStyle(
          background: theme.palette.getBackground(),
          textStyle: customStyle ??
              TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: theme.typography.subtitle1.fontSize,
                fontWeight: theme.typography.name.fontWeight,
                color: theme.palette.getAccent600(),
              ),
          border: Border.all(
            color: theme.palette.getBackground(),
            width: 0,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  // This is used to store the values in the same date stamp
  static String storeValueInMapTime(int? epochTimestampInSeconds) {
    if (epochTimestampInSeconds != null) {
      var dateTime =
          DateTime.fromMillisecondsSinceEpoch(epochTimestampInSeconds * 1000);

      var formatter = DateFormat("dd MMM yyyy");

      var formattedTime = formatter.format(dateTime);

      return formattedTime;
    }
    return "";
  }

  // Used to return time in hrs, minutes and secs
  static String formatMinutesAndSeconds(double totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes.toInt() % 60;
    int seconds = ((totalMinutes - totalMinutes.toInt()) * 60).round();
    if (seconds == 60) {
      minutes += 1;
      seconds = 0;
    }

    if (minutes == 60) {
      hours += 1;
      minutes = 0;
    }

    return "${hours > 0 ? "${hours}h " : ""}${minutes}m ${seconds.toString().padLeft(2, '0')}s";
  }

  // This will return the receiver avatar
  static String receiverAvatar(User? loggedInUser, CallLog? callLog) {
    if (loggedInUser != null && callLog != null) {
      if (callLog.initiator is CallUser && callLog.receiver is CallUser) {
        CallUser callUserInitiator = callLog.initiator as CallUser;
        CallUser callUserReceiver = callLog.receiver as CallUser;
        if (loggedInUser.uid == callUserInitiator.uid) {
          return callUserReceiver.avatar ?? "";
        } else {
          return callUserInitiator.avatar ?? "";
        }
      } else if (callLog.initiator is CallUser &&
          callLog.receiver is CallGroup) {
        CallUser callUserInitiator = callLog.initiator as CallUser;
        CallGroup callGroupReceiver = callLog.receiver as CallGroup;
        if (loggedInUser.uid == callUserInitiator.uid) {
          return callGroupReceiver.icon ?? "";
        } else {
          return callUserInitiator.avatar ?? "";
        }
      }
    }
    return "";
  }

  // This will return the receiver name
  static String receiverName(User? loggedInUser, CallLog? callLog) {
    if (loggedInUser != null && callLog != null) {
      if (callLog.initiator is CallUser && callLog.receiver is CallUser) {
        CallUser callUserInitiator = callLog.initiator as CallUser;
        CallUser callUserReceiver = callLog.receiver as CallUser;
        if (loggedInUser.uid == callUserInitiator.uid) {
          return callUserReceiver.name ?? "";
        } else {
          return callUserInitiator.name ?? "";
        }
      } else if (callLog.initiator is CallUser &&
          callLog.receiver is CallGroup) {
        CallUser callUserInitiator = callLog.initiator as CallUser;
        CallGroup callGroupReceiver = callLog.receiver as CallGroup;
        if (loggedInUser.uid == callUserInitiator.uid) {
          return callGroupReceiver.name ?? "";
        } else {
          return callUserInitiator.name ?? "";
        }
      }
    }
    return "";
  }

  // This will return the receiver uid for User and  guid for Group
  static String returnReceiverId(User? loggedInUser, CallLog? callLog) {
    if (loggedInUser != null && callLog != null) {
      if (callLog.initiator is CallUser && callLog.receiver is CallUser) {
        CallUser callUserInitiator = callLog.initiator as CallUser;
        CallUser callUserReceiver = callLog.receiver as CallUser;
        if (loggedInUser.uid == callUserInitiator.uid) {
          return callUserReceiver.uid ?? "";
        } else {
          return callUserInitiator.uid ?? "";
        }
      } else if (callLog.initiator is CallUser &&
          callLog.receiver is CallGroup) {
        CallUser callUserInitiator = callLog.initiator as CallUser;
        CallGroup callGroupReceiver = callLog.receiver as CallGroup;
        if (loggedInUser.uid == callUserInitiator.uid) {
          return callGroupReceiver.guid ?? "";
        } else {
          return callUserInitiator.uid ?? "";
        }
      }
    }
    return "";
  }

  // Check if the CallLog object is of a User or a Group
  static bool isUser(CallLog? callLog) {
    if (callLog != null) {
      if (callLog.initiator is CallUser && callLog.receiver is CallUser) {
        return true;
      }
    }
    return false;
  }

  // This will return the callLog list
  static List<CallLog> returnCallLogList(
      Map<String, List<CallLog>> groupedEntries, int index) {
    var date = groupedEntries.keys.elementAt(index);
    final logs = groupedEntries[date];
    return logs ?? [];
  }
}
