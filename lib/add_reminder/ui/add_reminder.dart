import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AddReminderScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  AddReminderScreen({required this.item});

  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  bool isActive = true;
  String selectedFrequency = "Every Day";
  String selectedDuration = "1 Week";
  String selectedTimeFrequency = "Twice a day";
  TimeOfDay morningTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay eveningTime = TimeOfDay(hour: 16, minute: 0);
  bool vibrate = false;
  String selectedAlarm = "Whistle";

  Future<void> _selectTime(BuildContext context, bool isMorning) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isMorning ? morningTime : eveningTime,
    );
    if (picked != null) {
      setState(() {
        if (isMorning) {
          morningTime = picked;
        } else {
          eveningTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Set Reminder",style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        backgroundColor: Color(0xFF8E8AA3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.item['image'] != null)
              FadeIn(
                child: Image.file(
                  widget.item['image'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            FadeInLeft(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(widget.item['description'], style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Switch(
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            FadeInUp(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Start Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ListTile(
                    title: Text("May 6, 2023"),
                    trailing: Icon(Icons.calendar_today),
                  ),
                  Text("Frequency", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Column(
                    children: ["Every Day", "Certain Days", "Cycle"].map((e) {
                      return RadioListTile(
                        title: Text(e),
                        value: e,
                        groupValue: selectedFrequency,
                        onChanged: (value) {
                          setState(() {
                            selectedFrequency = value.toString();
                          });
                        },
                      );
                    }).toList(),
                  ),
                  Divider(),
                  Text("Duration & Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedDuration,
                          items: ["1 Week", "2 Weeks", "1 Month"].map((String value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedDuration = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedTimeFrequency,
                          items: ["Once a day", "Twice a day", "Thrice a day"].map((String value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedTimeFrequency = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("${morningTime.format(context)}"),
                              subtitle: Text("1 Tablet"),
                              trailing: Icon(Icons.access_time),
                              onTap: () => _selectTime(context, true),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("${eveningTime.format(context)}"),
                              subtitle: Text("1 Tablet"),
                              trailing: Icon(Icons.access_time),
                              onTap: () => _selectTime(context, false),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Text("Sound & Notification", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Checkbox(
                        value: vibrate,
                        onChanged: (bool? value) {
                          setState(() {
                            vibrate = value!;
                          });
                        },
                      ),
                      Text("Vibrate"),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedAlarm,
                          items: ["Whistle", "Beep", "Chime"].map((String value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedAlarm = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
              
                ],
              ),
            ),

            SizedBox(height: 20),
            FadeInRight(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: Text("Set Reminder", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
