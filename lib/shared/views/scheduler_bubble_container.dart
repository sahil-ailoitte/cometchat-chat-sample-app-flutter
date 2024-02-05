import 'package:cometchat_flutter_sample_app/utils/widget_card.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

WidgetProps getSchedulerBubbleContainer(BuildContext context) {
  return WidgetProps(
    leadingImageURL: "assets/icons/schedule.png",
    leadingImageDimensions: 48,
    title: "Scheduler Bubble",
    description:
        "CometChatSchedulerBubble is a versatile type of message widget designed to facilitate easy and efficient event scheduling."
        "To learn more about this component tap here",
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.5,
            ),
            body: Center(
              child: CometChatSchedulerBubble(
                schedulerMessage: SchedulerMessage(
                  title: 'Meeting with Dr. Jacob',
                  avatarUrl: 'https://i.pravatar.cc/200',
                  // interactiveData: {},
                  receiverUid: 'superhero2',
                  receiverType: 'user',
                  muid: DateTime.now().millisecondsSinceEpoch.toString(),
                  duration: 30,
                  interactionGoal: InteractionGoal(
                      type: InteractionGoalType.anyAction, elementIds: ["1"]),
                  timezoneCode: "Asia/Kolkata",
                  bufferTime: 15,
                  availability: {
                    "monday": [TimeRange(from: "1100", to: "1900")],
                    "tuesday": [TimeRange(from: "1100", to: "1900")],
                    "wednesday": [TimeRange(from: "1100", to: "1900")],
                    "thursday": [TimeRange(from: "0000", to: "2400")],
                    "friday": [TimeRange(from: "1100", to: "2400")],
                  },
                  // icsFileUrl: "https://data-us.cometchat.io/23965108c9b89ad2/media/1703674412_720466602_2991dab190899132b5fbdf1d83fadc04.ics",
                  icsFileUrl:
                      "https://data-us.cometchat.io/23965108c9b89ad2/media/1704380186_864562419_ab59586ed5ab5f89d2c960457ceee249.ics",
                  sender:
                      User(uid: "Dr. Jacob Twarog", name: "Dr. Jacob Twarog"),
                  receiver: User(name: "Trienke", uid: "Trienke"),
                  dateRangeStart: DateTime.now().toString(),
                  dateRangeEnd:
                      DateTime.now().add(Duration(days: 90)).toString(),
                  //     meetingDateRangeEnd : DateTime.now().millisecondsSinceEpoch,
                  // meetingDateRangeStart : DateTime.now().add(Duration(days: 9)).millisecondsSinceEpoch,
                  scheduleElement: ButtonElement(
                    buttonText: "Schedule",
                    action: APIAction(url: "url", method: "method"),
                    elementType: UIElementTypeConstants.button,
                    elementId: "1",
                    disableAfterInteracted: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
