import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:medicine_reminder/add_reminder/ui/add_reminder.dart';
import '../../add_medicine/ui/add_medicine.dart';
import '../controller/medicine_controller.dart';

// Controller for managing the medicine list


class MedicineList extends StatelessWidget {
  final MedicineController controller = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: Obx(
            () => controller.items.isEmpty
            ? Center(
          child: Text(
            "No items added",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return FadeInDown(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 6.0),
                child: Dismissible(
                  key: Key(controller.items[index]['title']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    controller.removeItem(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Row(
                      children: [
                        // Image (40%)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: controller.items[index]['image'] != null
                                ? DecorationImage(
                              image: FileImage(
                                  controller.items[index]['image']),
                              fit: BoxFit.cover,
                            )
                                : DecorationImage(
                              image: AssetImage(
                                  "assets/images/placeholder.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Title & Subtitle (40%)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.items[index]['title'],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey.shade800,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                controller.items[index]['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Navigate Button (20%)
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueGrey.shade700,
                            size: 24,
                          ),
                          onPressed: () {
                            Get.to(() => AddReminderScreen(
                                item: controller.items[index]));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Get.to(() => AddMedicine(onSave: controller.addItem)),
      ),
    );
  }
}
