import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_reminder_controller.dart';

class AddReminderScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  AddReminderScreen({required this.item});

  final AddReminderController _controller = Get.put(AddReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Set Reminder",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF8E8AA3), // Main color
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Light background color
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item['image'] != null)
                FadeIn(
                  child: Image.file(
                    item['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              FadeInLeft(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                            ),
                            Text(
                              item['description'],
                              style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _controller.isNotificationOn.toggle();
                          },
                          child: Obx(() => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: _controller.isNotificationOn.value ? Color(0xFF8E8AA3) : Colors.grey[400],
                            ),
                            alignment: _controller.isNotificationOn.value ? Alignment.centerRight : Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              _controller.isNotificationOn.value ? Icons.notifications_active : Icons.notifications_off,
                              color: Colors.white,
                              size: 18,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(color: Color(0xFFE0E0E0)),
              FadeInUp(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Start Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        ListTile(
                          title: Obx(() => Text(
                            _controller.startDate.value != null
                                ? "${_controller.startDate.value!.toLocal()}".split(' ')[0]
                                : "Select Start Date",
                            style: TextStyle(color: Color(0xFF666666)),
                          )),
                          trailing: Icon(Icons.calendar_today, color: Color(0xFF8E8AA3)),
                          onTap: () => _controller.selectDate(context, true),
                        ),
                        Text("End Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        ListTile(
                          title: Obx(() => Text(
                            _controller.endDate.value != null
                                ? "${_controller.endDate.value!.toLocal()}".split(' ')[0]
                                : "Select End Date",
                            style: TextStyle(color: Color(0xFF666666)),
                          )),
                          trailing: Icon(Icons.calendar_today, color: Color(0xFF8E8AA3)),
                          onTap: () => _controller.selectDate(context, false),
                        ),
                        Divider(color: Color(0xFFE0E0E0)),
                        Text("Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Obx(() => Text(_controller.morningTime.value.format(context), style: TextStyle(color: Color(0xFF666666)))),
                                  subtitle: Text("Morning Dose", style: TextStyle(color: Color(0xFF666666))),
                                  trailing: Icon(Icons.access_time, color: Color(0xFF8E8AA3)),
                                  onTap: () => _controller.selectTime(context, "Morning"),
                                ),
                                Obx(() => DropdownButton<String>(
                                  value: _controller.selectedMorningMealTiming.value,
                                  onChanged: (String? newValue) {
                                    _controller.selectedMorningMealTiming.value = newValue!;
                                  },
                                  items: _controller.mealTimings["Morning"]!.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color: Color(0xFF333333))),
                                    );
                                  }).toList(),
                                )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Obx(() => Text(_controller.eveningTime.value.format(context), style: TextStyle(color: Color(0xFF666666)))),
                                  subtitle: Text("Evening Dose", style: TextStyle(color: Color(0xFF666666))),
                                  trailing: Icon(Icons.access_time, color: Color(0xFF8E8AA3)),
                                  onTap: () => _controller.selectTime(context, "Evening"),
                                ),
                                Obx(() => DropdownButton<String>(
                                  value: _controller.selectedEveningMealTiming.value,
                                  onChanged: (String? newValue) {
                                    _controller.selectedEveningMealTiming.value = newValue!;
                                  },
                                  items: _controller.mealTimings["Evening"]!.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color: Color(0xFF333333))),
                                    );
                                  }).toList(),
                                )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Obx(() => Text(_controller.nightTime.value.format(context), style: TextStyle(color: Color(0xFF666666)))),
                                  subtitle: Text("Night Dose", style: TextStyle(color: Color(0xFF666666))),
                                  trailing: Icon(Icons.access_time, color: Color(0xFF8E8AA3)),
                                  onTap: () => _controller.selectTime(context, "Night"),
                                ),
                                Obx(() => DropdownButton<String>(
                                  value: _controller.selectedNightMealTiming.value,
                                  onChanged: (String? newValue) {
                                    _controller.selectedNightMealTiming.value = newValue!;
                                  },
                                  items: _controller.mealTimings["Night"]!.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color: Color(0xFF333333))),
                                    );
                                  }).toList(),
                                )),
                              ],
                            ),
                          ],
                        ),
                        Divider(color: Color(0xFFE0E0E0)),
                        Text("Sound & Notification", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        Column(
                          children: [
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                  value: _controller.vibrate.value,
                                  onChanged: (bool? value) {
                                    _controller.vibrate.value = value!;
                                  },
                                  activeColor: Color(0xFF8E8AA3), // Main color
                                )),
                                Text("Vibrate", style: TextStyle(color: Color(0xFF333333))),
                                SizedBox(width: 16),

                              ],
                            ),
                            Obx(() => Wrap(
                              spacing: 10,
                              children: ["Whistle", "Beep", "Chime"].map((e) {
                                return ChoiceChip(
                                  label: Text(e, style: TextStyle(color: _controller.selectedAlarm.value == e ? Colors.white : Color(0xFF333333))),
                                  selected: _controller.selectedAlarm.value == e,
                                  onSelected: (selected) {
                                    _controller.selectedAlarm.value = e;
                                  },
                                  selectedColor: Color(0xFF8E8AA3), // Main color
                                  backgroundColor: Colors.white,
                                );
                              }).toList(),
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF8E8AA3), // Main color
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Add Reminder",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}