import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:medicine_reminder/add_reminder/ui/add_reminder.dart';
import '../../add_medicine/controller/medicine_controller.dart';
import '../../add_medicine/model/add_mdecine_model.dart';
import '../../add_medicine/ui/add_medicine.dart';
import '../../medicine_storage_update/ui/medicine_storage_update_screen.dart';

class MedicineListScreen extends StatefulWidget {
  @override
  State<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  final MedicineController1 controller = Get.put(MedicineController1());
  @override
  void dispose() {
    controller.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: "Search medicines...",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                  suffixIcon: controller.searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.blueGrey),
                    onPressed: () {
                      controller.searchController.clear();
                      controller.update(); // Refresh the UI after clearing the search query
                    },
                  )
                      : null,
                ),
                style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
            ),
          ),
          // Medicine List
          Expanded(
            child: Obx(
                  () {
                if (controller.filteredItems.isEmpty) {
                  return const Center(
                    child: Text(
                      "No medicines found!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredItems[index];
                    return FadeInRight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        child: Dismissible(
                          key: Key(item.title),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: const EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                          ),
                          onDismissed: (direction) {
                            controller.removeItem(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: (item.imagePath != null)
                                          ? FileImage(File(item.imagePath!))
                                          : const AssetImage("assets/images/placeholder.png") as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.description,
                                        style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blueGrey,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    Get.to(() => AddReminderScreen(item: {
                                      'title': item.title,
                                      'description': item.description,
                                      'image': item.imagePath != null
                                          ? File(item.imagePath!)
                                          : null,
                                    }));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6A5ACD),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Get.to(() => AddMedicine()),
      ),
    );
  }
}