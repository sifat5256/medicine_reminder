import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/add_mdecine_model.dart'; // Import the MedicineModel

class MedicineController1 extends GetxController {
  var medicines = <MedicineModel>[].obs; // For storage tracking
  var items = <MedicineModel>[].obs; // For the medicine list
  final TextEditingController searchController = TextEditingController();




  @override
  void onInit() {
    super.onInit();
    loadMedicines();
    loadItems();
    searchController.addListener(() {
      update(); // Refresh the UI when the search query changes
    });
  }

  @override
  void onClose() {
    //searchController.dispose();
    super.onClose();

  }

  // Load medicines for storage tracking
  Future<void> loadMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? medicinesJson = prefs.getStringList('medicines') ?? [];
    medicines.value = medicinesJson.map((json) => MedicineModel.fromJson(jsonDecode(json))).toList();
  }

  // Load items for the medicine list
  Future<void> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsJson = prefs.getStringList('items') ?? [];
    items.value = itemsJson.map((json) => MedicineModel.fromJson(jsonDecode(json))).toList();
  }

  // Add a new medicine
  void addItem(String title, String description, File? image) async {
    MedicineModel newMedicine = MedicineModel(
      title: title,
      description: description,
      imagePath: image?.path,
    );
    items.add(newMedicine);
    await _saveItem(newMedicine);
  }

  // Save item to SharedPreferences
  Future<void> _saveItem(MedicineModel item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = prefs.getStringList('items') ?? [];
    itemsJson.add(jsonEncode(item.toJson()));
    await prefs.setStringList('items', itemsJson);
  }

  // Remove a medicine
  void removeItem(int index) async {
    items.removeAt(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('items', itemsJson);
  }

  // Update dosage for a medicine
  void updateDosage(int index, int dosage) async {
    medicines[index].dosage = dosage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('${medicines[index].title}_dosage', dosage);
    medicines.refresh();
  }

  // Update stock for a medicine
  void updateStock(int index, int stock) async {
    medicines[index].stock = stock;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('${medicines[index].title}_stock', stock);
    medicines.refresh();
  }

  // Subtract daily dosage for all medicines
  void subtractDailyDosage() async {
    for (var medicine in medicines) {
      if (medicine.stock > 0) {
        medicine.stock -= medicine.dosage;
        if (medicine.stock < 0) medicine.stock = 0;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('${medicine.title}_stock', medicine.stock);
      }
    }
    medicines.refresh();
  }

  // Clear all medicines
  void clearAllMedicines() async {
    medicines.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('medicines');
  }

  // Filtered medicines for storage tracking
  List<MedicineModel> get filteredMedicines {
    if (searchController.text.isEmpty) {
      return medicines;
    } else {
      return medicines
          .where((medicine) => medicine.title
          .toLowerCase()
          .contains(searchController.text.toLowerCase()))
          .toList();
    }
  }

  // Filtered items for the medicine list
  List<MedicineModel> get filteredItems {
    if (searchController.text.isEmpty) {
      return items;
    } else {
      return items
          .where((item) => item.title
          .toLowerCase()
          .contains(searchController.text.toLowerCase()))
          .toList();
    }
  }
}