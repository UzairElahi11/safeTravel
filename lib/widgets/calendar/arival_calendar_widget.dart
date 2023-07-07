import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class ArrivalCalendar extends StatefulWidget {
  DateTime focusDay;
  ArrivalCalendar({
    super.key,
    required this.focusDay,
  });

  @override
  State<ArrivalCalendar> createState() => _ArrivalCalendarState();
}

class _ArrivalCalendarState extends State<ArrivalCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onFormatChanged: (format) {},
      weekendDays: const [DateTime.saturday, DateTime.sunday],
      holidayPredicate: (day) {
        return false;
      },
      currentDay: widget.focusDay,
      headerStyle: HeaderStyle(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
          ),
          titleCentered: true),
      calendarStyle: CalendarStyle(
        outsideDecoration: BoxDecoration(color: AppColors.blackColor),
        weekendTextStyle: AppStyles.small12.copyWith(
          color: AppColors.redColor,
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.baseColor,
        ),
        todayTextStyle: AppStyles.small12.copyWith(
          color: AppColors.whiteColor,
        ),
        isTodayHighlighted: true,
        outsideDaysVisible: false,
        holidayTextStyle: AppStyles.small12.copyWith(color: AppColors.redColor),
      ),
      locale: context.locale.languageCode == 'en' ? 'EN_US' : 'ES_MX',
      daysOfWeekVisible: true,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: AppColors.redColor),
      ),
      focusedDay: widget.focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2050),
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      rowHeight: 60.0,
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          widget.focusDay = focusedDay;
        });
      },
      onPageChanged: (focusDay) {},
    );
  }
}
