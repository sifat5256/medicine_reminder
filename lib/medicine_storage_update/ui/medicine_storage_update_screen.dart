import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../main_layout.dart';

class Medicine {
  String name;
  String image;
  String capacity;
  int dosage;
  int stock;

  Medicine({
    required this.name,
    required this.image,
    required this.capacity,
    this.dosage = 1,
    this.stock = 10,
  });
}

class MedicineController extends GetxController {
  var medicines = <Medicine>[].obs;

  @override
  void onInit() {
    super.onInit();
    medicines.addAll([
      Medicine(name: "Paracetamol", image: "https://via.placeholder.com/50", capacity: "500mg"),
      Medicine(name: "Ibuprofen", image: "https://via.placeholder.com/50", capacity: "200mg"),
      Medicine(name: "Aspirin", image: "https://via.placeholder.com/50", capacity: "100mg"),
    ]);
  }

  void updateDosage(int index, int dosage) {
    medicines[index].dosage = dosage;
    medicines.refresh();
  }

  void updateStock(int index, int stock) {
    medicines[index].stock = stock;
    medicines.refresh();
  }
}

class MedicineStorageUpdateScreen extends StatefulWidget {
  const MedicineStorageUpdateScreen({super.key});

  @override
  State<MedicineStorageUpdateScreen> createState() => _MedicineStorageUpdateScreenState();
}

class _MedicineStorageUpdateScreenState extends State<MedicineStorageUpdateScreen> {
  final MedicineController controller = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Get.offAll(BottomNavBar());
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),),
        backgroundColor: Colors.cyan,
        centerTitle: true,

          title: const Text("Medicine Storage")),
      body: Obx(
            () => ListView.builder(
          itemCount: controller.medicines.length,
          itemBuilder: (context, index) {
            final medicine = controller.medicines[index];
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
                  dashPattern: [6, 3],
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(medicine.image, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          medicine.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200
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
                        Text("Stock: ${medicine.stock} remaining", style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
                      ],
                    ),

                  ),
                ),
              ),
            );
          },
        ),
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
