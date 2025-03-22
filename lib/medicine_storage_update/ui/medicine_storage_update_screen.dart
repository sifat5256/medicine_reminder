import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../add_medicine/controller/medicine_controller.dart';
import '../../main_layout.dart';

class MedicineStorageUpdateScreen extends StatefulWidget {
  @override
  State<MedicineStorageUpdateScreen> createState() => _MedicineStorageUpdateScreenState();
}

class _MedicineStorageUpdateScreenState extends State<MedicineStorageUpdateScreen> {
  final MedicineController1 controller = Get.put(MedicineController1());

  @override
  void initState() {
    super.initState();
    // Load medicines and items on screen initialization
    controller.loadMedicines();
    controller.loadItems();
  }

  @override
  void dispose() {
    controller.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAll(BottomNavBar());
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text("Medicine Storage"),
      ),
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
          // Medicine Storage List
          Expanded(
            child: Obx(
                  () {
                if (controller.filteredMedicines.isEmpty) {
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
                  itemCount: controller.filteredMedicines.length,
                  itemBuilder: (context, index) {
                    final medicine = controller.filteredMedicines[index];
                    return TweenAnimationBuilder(
                      tween: Tween<Offset>(
                        begin: const Offset(1, 0), // Start from right
                        end: Offset.zero,
                      ),
                      duration: Duration(milliseconds: 500 * (index + 1)),
                      builder: (context, Offset offset, child) {
                        return Transform.translate(
                          offset: offset,
                          child: child,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          color: Colors.greenAccent,
                          strokeWidth: 1.5,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [6, 3],
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                medicine.imagePath ?? "assets/images/placeholder.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  medicine.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 26),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () => _showUpdateDialog(index, true),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_box, color: Colors.green),
                                        onPressed: () => _showUpdateDialog(index, false),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Capacity: ${medicine.capacity}", style: const TextStyle(fontSize: 14)),
                                Text("Dosage: ${medicine.dosage} times/day", style: const TextStyle(fontSize: 14)),
                                Text(
                                  "Stock: ${medicine.stock} remaining",
                                  style: TextStyle(
                                    color: medicine.stock <= 5 ? Colors.red : Colors.green,
                                    fontSize: 14,
                                  ),
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
    );
  }

  void _showUpdateDialog(int index, bool isDosage) {
    final TextEditingController controllerField = TextEditingController();
    String title = isDosage ? "Update Dosage" : "Update Stock";
    String label = isDosage ? "Times per day" : "Stock Count";

    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controllerField,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            onPressed: () {
              if (controllerField.text.isNotEmpty) {
                int value = int.parse(controllerField.text);
                if (isDosage) {
                  controller.updateDosage(index, value);
                } else {
                  controller.updateStock(index, value);
                }
                Get.back();
              }
            },
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
