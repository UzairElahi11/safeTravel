import 'package:flutter/material.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  static const id = "CALENDAR_SCREEN";
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(color: AppColors.baseColor, width: 2.0),
              ),
              child: TableCalendar(
                // today's date
                focusedDay: DateTime.now(),
                // earliest possible date
                firstDay: DateTime.now(),
                // latest allowed date
                lastDay: DateTime.now(),
                // default view when displayed
                calendarFormat: CalendarFormat.month,
                // default is Saturday & Sunday but can be set to any day.
                // instead of day, a number can be mentioned as well.
                weekendDays: const [DateTime.sunday, 6],
                // default is Sunday but can be changed according to locale
                startingDayOfWeek: StartingDayOfWeek.monday,
                // height between the day row and 1st date row, default is 16.0
                daysOfWeekHeight: 40.0,
                // height between the date rows, default is 52.0
                rowHeight: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
