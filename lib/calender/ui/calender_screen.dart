import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController = CalendarController();
  DateTime _selectedWeekStart = DateTime(2024, 5, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
         SizedBox(
           height: 20,
         ),


          // Calendar View
          Expanded(
            child: FadeInUp(
              child: SfCalendar(
                controller: _calendarController,
                view: CalendarView.week,
                firstDayOfWeek: 6, // Start from Saturday
                dataSource: MedicineDataSource(_getMedicineAppointments()),
                timeSlotViewSettings: TimeSlotViewSettings(
                  timeFormat: 'h a', // 12-hour format (8 AM, 10 AM)
                  startHour: 8, // Start at 8 AM
                  endHour: 24, // End at 6 PM
                  timeTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                appointmentTextStyle: TextStyle(fontSize: 14, color: Colors.white),
                headerHeight: 0, // Hide default header
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Custom week header for navigation
  Widget _buildWeekHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, size: 28),
            onPressed: () {
              setState(() {
                _selectedWeekStart = _selectedWeekStart.subtract(Duration(days: 7));
              });
            },
          ),
          Text(
            "${_formatDate(_selectedWeekStart)} - ${_formatDate(_selectedWeekStart.add(Duration(days: 6)))}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, size: 28),
            onPressed: () {
              setState(() {
                _selectedWeekStart = _selectedWeekStart.add(Duration(days: 7));
              });
            },
          ),
        ],
      ),
    );
  }

  /// Function to format the date
  String _formatDate(DateTime date) {
    return "${date.day} ${_getMonthName(date.month)}";
  }

  /// Function to get month name
  String _getMonthName(int month) {
    List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  /// Function to get medicine reminders
  List<Appointment> _getMedicineAppointments() {
    return [
      Appointment(
        startTime: DateTime(2024, 5, 6, 8, 0),
        endTime: DateTime(2024, 5, 6, 8, 5),
        subject: 'Aspirin 8:00 AM',
        color: Colors.orange,
      ),
      Appointment(
        startTime: DateTime(2024, 5, 7, 9, 0),
        endTime: DateTime(2024, 5, 7, 9, 30),
        subject: 'Blood Test 9:00 AM',
        color: Colors.blue,
      ),
      Appointment(
        startTime: DateTime(2024, 5, 9, 12, 0),
        endTime: DateTime(2024, 5, 9, 12, 30),
        subject: 'Coloplast 12:00 PM',
        color: Colors.red,
      ),
      Appointment(
        startTime: DateTime(2024, 5, 11, 12, 0),
        endTime: DateTime(2024, 5, 11, 12, 30),
        subject: 'Visit Therapist 12:00 PM',
        color: Colors.green,
      ),
    ];
  }
}

/// Custom data source for medicine reminders
class MedicineDataSource extends CalendarDataSource {
  MedicineDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
