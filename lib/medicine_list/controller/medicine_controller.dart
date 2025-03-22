// import 'dart:io';
//
// import 'package:get/get.dart';
//
// import '../../add_medicine/model/add_mdecine_model.dart';
//  // Import the Medicine model
//
// class MedicineController extends GetxController {
//   var items = <Medicine>[].obs; // Use RxList<Medicine>
//
//   void addItem(String title, String description, File? image) {
//     Medicine newMedicine = Medicine(
//       title: title,
//       description: description,
//       imagePath: image?.path,
//     );
//     items.add(newMedicine);
//   }
//
//   void removeItem(int index) {
//     items.removeAt(index);
//   }
// }