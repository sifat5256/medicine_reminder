import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrescriptionController extends GetxController {

  var files = <Map<String, String>>[].obs; // List to store uploaded files

  void addFile(String title, String filePath) {
    files.add({"title": title, "path": filePath, "date": DateTime.now().toString()});
  }

  void deleteFile(int index) {
    files.removeAt(index);
  }
  RxString filePath = ''.obs;
  RxString fileTitle = ''.obs;
  RxString dateTime = ''.obs;

  void pickFile(String title, String path) {
    fileTitle.value = title;
    filePath.value = path;
    dateTime.value = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }
}
