

import 'dart:io';

import 'package:get/get.dart';

class MedicineController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;

  void addItem(String title, String description, File? image) {
    items.add({"title": title, "description": description, "image": image});
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}