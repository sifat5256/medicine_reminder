import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReminderController extends GetxController {
  // Reactive variables
  var isNotificationOn = true.obs;
  var selectedFrequency = "Every Day".obs;
  var selectedMorningMealTiming = "Before Breakfast".obs;
  var selectedEveningMealTiming = "Before Lunch".obs;
  var selectedNightMealTiming = "Before Dinner".obs;
  var morningTime = TimeOfDay(hour: 8, minute: 0).obs;
  var eveningTime = TimeOfDay(hour: 16, minute: 0).obs;
  var nightTime = TimeOfDay(hour: 0, minute: 0).obs; // Midnight
  var vibrate = false.obs;
  var selectedAlarm = "Whistle".obs;
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);

  final Map<String, List<String>> mealTimings = {
    "Morning": ["Before Breakfast", "After Breakfast"],
    "Evening": ["Before Lunch", "After Lunch"],
    "Night": ["Before Dinner", "After Dinner"],
  };

  // Function to select time
  Future<void> selectTime(BuildContext context, String timeType) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeType == "Morning"
          ? morningTime.value
          : timeType == "Evening"
          ? eveningTime.value
          : nightTime.value,
    );
    if (picked != null) {
      if (timeType == "Morning") {
        morningTime.value = picked;
      } else if (timeType == "Evening") {
        eveningTime.value = picked;
      } else {
        nightTime.value = picked;
      }
    }
  }

  // Function to select date
  Future<void> selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isStart) {
        startDate.value = picked;
      } else {
        endDate.value = picked;
      }
    }
  }
}