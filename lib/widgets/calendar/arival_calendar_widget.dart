
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class ArrivalCalendar extends StatelessWidget {
  const ArrivalCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(

      weekendDays: const [DateTime.saturday, DateTime.sunday],
      holidayPredicate: (day) {
        return false;
      },
      currentDay: DateTime.now(),
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
      locale: context.locale.languageCode == 'en' ? 'EN_US' :'ES_MX',
      daysOfWeekVisible: true,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: AppColors.redColor),
      ),
      focusedDay: DateTime.now(),
      firstDay: DateTime(2000),
      lastDay: DateTime(2050),
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekHeight: 40.0,
      rowHeight: 60.0,
    );
  }
}
