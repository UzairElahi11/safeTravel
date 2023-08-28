import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class ArrivalCalendar extends StatefulWidget {
  const ArrivalCalendar({
    super.key,
  });

  @override
  State<ArrivalCalendar> createState() => _ArrivalCalendarState();
}

class _ArrivalCalendarState extends State<ArrivalCalendar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(builder: (context, model, _) {
      return TableCalendar(
        onFormatChanged: (format) {},
        weekendDays: const [DateTime.saturday, DateTime.sunday],
        holidayPredicate: (day) {
          return false;
        },
        currentDay: model.arrivalfocusDay,
        headerStyle: HeaderStyle(
            formatButtonShowsNext: false,
            formatButtonVisible: false,
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
          holidayTextStyle:
              AppStyles.small12.copyWith(color: AppColors.redColor),
        ),
        locale: context.locale.languageCode == 'en' ? 'EN_US' : 'ES_MX',
        daysOfWeekVisible: true,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: AppColors.redColor),
        ),
        focusedDay: model.arrivalfocusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2050),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        rowHeight: 45.0,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            model.arrivalfocusDay = focusedDay;
          });

          log("selected date is ${model.arrivalfocusDay}");
        },
        onPageChanged: (focusDay) {},
      );
    });
  }
}

class DepartureCalendat extends StatefulWidget {
  const DepartureCalendat({
    super.key,
  });

  @override
  State<DepartureCalendat> createState() => _DepartureCalendatState();
}

class _DepartureCalendatState extends State<DepartureCalendat> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(builder: (context, model, _) {
      return TableCalendar(
        onFormatChanged: (format) {},
        weekendDays: const [DateTime.saturday, DateTime.sunday],
        holidayPredicate: (day) {
          return false;
        },
        currentDay: model.departureFocusDay,
        headerStyle: HeaderStyle(
            formatButtonShowsNext: false,
            formatButtonVisible: false,
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
          holidayTextStyle:
              AppStyles.small12.copyWith(color: AppColors.redColor),
        ),
        locale: context.locale.languageCode == 'en' ? 'EN_US' : 'ES_MX',
        daysOfWeekVisible: true,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: AppColors.redColor),
        ),
        focusedDay: model.arrivalfocusDay.add(
          Duration(days: 3),
        ),
        firstDay: model.arrivalfocusDay.add(
          Duration(days: 1),
        ),
        lastDay: DateTime(2050),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        rowHeight: 45.0,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            model.departureFocusDay = focusedDay;
          });

          log("selected date is ${model.departureFocusDay}");
        },
        onPageChanged: (focusDay) {},
      );
    });
  }
}
