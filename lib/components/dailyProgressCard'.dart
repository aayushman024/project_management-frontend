// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyProgress extends StatefulWidget {
  const DailyProgress({super.key});

  @override
  State<DailyProgress> createState() => _DailyProgressState();
}

class _DailyProgressState extends State<DailyProgress> {
  List<String> notes = [
    "Meeting with team",
    "Design review",
    "Code deployment",
    "Client feedback",
    "Feature update",
    "Testing",
    "Bug fixes",
    // Add notes for more days as required
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SfCalendar(
              view: CalendarView.month,
              headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(color: Colors.white, fontSize: 18),
              ),
              monthViewSettings: MonthViewSettings(
                showAgenda: false,
                agendaViewHeight: 0, // Disable default agenda view
              ),
              dataSource: MeetingDataSource(_getDataSource()),
              showNavigationArrow: true,
              todayHighlightColor: Colors.green,
            );
          // Custom notes list on the right
  }

  List<Appointment> _getDataSource() {
    final List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Team Meeting',
      color: Colors.blue,
    ));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
