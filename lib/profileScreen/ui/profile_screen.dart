import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  var userName = "John Doe".obs;
  var userEmail = "johndoe@example.com".obs;
  var medicineReminder = "Take Aspirin at 8 AM".obs;
  var medicineTaken = 5.obs;
  var medicineMissed = 2.obs;
  var selectedPeriod = "Today".obs;
  var profileImage = Rx<File?>(null);

  void updateProfile(String name, String email) {
    userName.value = name;
    userEmail.value = email;
  }

  void updateReminder(String reminder) {
    medicineReminder.value = reminder;
  }

  void updatePeriod(String period) {
    selectedPeriod.value = period;

    // Update medicineTaken and medicineMissed based on the selected period
    switch (period) {
      case "Today":
        medicineTaken.value = 5;
        medicineMissed.value = 2;
        break;
      case "Last 7 Days":
        medicineTaken.value = 10;
        medicineMissed.value = 5;
        break;
      case "Last 15 Days":
        medicineTaken.value = 12;
        medicineMissed.value = 4;
        break;
      case "Last 1 Month":
        medicineTaken.value = 13;
        medicineMissed.value = 6;
        break;
      default:
        medicineTaken.value = 0;
        medicineMissed.value = 0;
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }
}

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Obx(
                        () => CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.deepPurple.shade200,
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(controller.profileImage.value!)
                          : null,
                      child: controller.profileImage.value == null
                          ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(() => Text("Name: ${controller.userName}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
              SizedBox(height: 10),
              Obx(() => Text("Email: ${controller.userEmail}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
              SizedBox(height: 20),
              Obx(() => Text("Medicine Reminder: ${controller.medicineReminder}",
                  style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              Text("Medicine Adherence", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPeriodButton("Today"),
                  _buildPeriodButton("Last 7 Days"),
                  _buildPeriodButton("Last 15 Days"),
                  _buildPeriodButton("Last 1 Month"),
                ],
              ),
              SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 1.5,
                child: Obx(
                      () => BarChart(
                    BarChartData(
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              borderRadius: BorderRadius.circular(0),
                              toY: controller.medicineTaken.value.toDouble(),
                              color: Colors.green,
                              width: 50,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              borderRadius: BorderRadius.circular(0),
                              toY: controller.medicineMissed.value.toDouble(),
                              color: Colors.red,
                              width: 50,
                            ),
                          ],
                        ),
                      ],
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return Text('Taken', style: TextStyle(fontSize: 12));
                                case 1:
                                  return Text('Missed', style: TextStyle(fontSize: 12));
                                default:
                                  return Text('');
                              }
                            },
                          ),
                        ),
                      ),
                      barTouchData: BarTouchData(enabled: false),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    return Obx(
          () => ElevatedButton(
        onPressed: () => controller.updatePeriod(period),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),

          elevation: 0,
          backgroundColor: controller.selectedPeriod.value == period ? Colors.orange : Colors.grey.shade200,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        child: Text(period, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: controller.selectedPeriod.value==period?Colors.white:Colors.black)),
      ),
    );
  }
}