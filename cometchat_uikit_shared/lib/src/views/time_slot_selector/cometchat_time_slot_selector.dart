import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

enum TimeFormat {
  twelveHour, twentyFourHour
}

class CometChatTimeSlotSelector extends StatefulWidget {
  const CometChatTimeSlotSelector({Key? key,
     this.from,  this.to,
    required this.duration, this.onSelection, this.buffer, this.theme,this.style, this.blockedTime, this.timeFormat = TimeFormat.twelveHour, this.availableSlots, required this.selectedDay, this.nextDayBlockedTime, this.nextDayAvailableSlots}):super(key:key);

  ///[from] is a string which sets the start time for the time slot selector
  final DateTime? from;
  ///[to] is a string which sets the end time for the time slot selector
  final DateTime? to;
  ///[duration] is a Duration which sets the duration of the time slot selector
  final Duration duration;
  ///[onSelection] is a callback which gets called when a time slot is selected
  final Function(DateTime selectedTime)? onSelection;
  ///[buffer] is a Duration which sets the buffer time for the time slot selector
  final Duration? buffer;
  ///[theme] is a object of [CometChatTheme] which is used to set the theme for the time slot selector
  final CometChatTheme? theme;
  ///[style] is a object of [TimeSlotSelectorStyle] which is used to set the style for the time slot selector
  final TimeSlotSelectorStyle? style;

  ///[blockedTime] is a list of [TimeRange] which is used to block the time slots
  final List<DateTimeRange>? blockedTime;

  ///[availableSlots] is a list of [TimeRange] which is used to set the available time slots
  final List<DateTimeRange>? availableSlots;

  ///[timeFormat] is a enum of [TimeFormat] which is used to set the time format for the time slot selector
  final TimeFormat timeFormat;

  ///[selectedDay] is a DateTime which is used to set the selected day for the time slot selector`
  final DateTime selectedDay;

  ///[nextDayBlockedTime] is a list of [TimeRange] which is used to block the time slots
  final List<DateTimeRange>? nextDayBlockedTime;

  ///[nextDayAvailableSlots] is a list of [TimeRange] which is used to set the available time slots
  final List<DateTimeRange>? nextDayAvailableSlots;

  @override
  State<CometChatTimeSlotSelector> createState() => _CometChatTimeSlotSelectorState();
}

class _CometChatTimeSlotSelectorState extends State<CometChatTimeSlotSelector> {

   List<DateTime> timeList=[];

  late DateTime selectedTime;

  late CometChatTheme theme;

  @override
  void initState() {
    theme = widget.theme ?? cometChatTheme;
    selectedTime = widget.selectedDay;
    if(widget.availableSlots != null && widget.availableSlots!.isNotEmpty) {
      timeList = SchedulerUtils.generateTimeStamps(widget.selectedDay,widget.availableSlots!, widget.blockedTime??[], widget.duration.inMinutes, widget.buffer ?? Duration.zero, widget.timeFormat, widget.nextDayAvailableSlots ?? [], widget.nextDayBlockedTime ?? []);
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return timeList.isEmpty? Text(Translations.of(context).timeSlotUnavailable) : SizedBox(
      // height: 240,
      width: 275,
      child: GridView.count(
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,padding: const EdgeInsets.all(0),
shrinkWrap: true,
        childAspectRatio: 3,
        crossAxisCount: 3,
        children: getTimeSlots(),
      ),
    );
  }

  List<Widget> getTimeSlots(){
    return timeList.map((time) {

      return GestureDetector(
        onTap: () {
          if (widget.onSelection != null) {
            widget.onSelection!(time);
          }
          setState(() {
            selectedTime = time;
          });

        },
        child: Container(
          height: widget.style?.height ?? 32,
          width: widget.style?.width ?? 91,
          key: ValueKey(time),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedTime == time
                ? widget.style?.selectedSlotBackgroundColor ??
                theme.palette.getPrimary()
                : widget.style?.slotBackgroundColor ??
                theme.palette.getBackground(),

            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
              SchedulerUtils.getFormattedTime(time, widget.timeFormat),
              style: TextStyle(
                color: selectedTime == time? theme.palette.backGroundColor.light : theme.palette.getAccent700(),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ).merge(selectedTime == time
                  ? widget.style?.selectedSlotTextStyle
                  : widget.style?.slotTextStyle)
          ),
        ),
      );
    }).toList();
  }

}
