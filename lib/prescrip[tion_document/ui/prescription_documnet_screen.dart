import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controller/prescription_document_controller.dart';

class StorePrescriptionHealthDocument extends StatefulWidget {
  const StorePrescriptionHealthDocument({super.key});

  @override
  State<StorePrescriptionHealthDocument> createState() =>
      _StorePrescriptionHealthDocumentState();
}

class _StorePrescriptionHealthDocumentState
    extends State<StorePrescriptionHealthDocument> {
  final PrescriptionController controller = Get.put(PrescriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Documents'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Obx(() {
        return controller.files.isEmpty
            ? Center(
          child: Text(
            "No document uploaded",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ).animate().fade(duration: 500.ms),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.files.length,
          itemBuilder: (context, index) {
            final file = controller.files[index];
            return Card(
              elevation: 4,
              color: Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  "Title: ${file['title']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Uploaded: ${file['date']}",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.deleteFile(index);
                  },
                ),
              ),
            ).animate().fade(duration: 500.ms);
          },
        );

      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.upload_file, color: Colors.white),
        label: const Text("Upload", style: TextStyle(color: Colors.white)),
        onPressed: () {
          showUploadBottomSheet(context);
        },
      ).animate().scale(duration: 400.ms),
    );
  }

  void showUploadBottomSheet(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Text(
              "Upload Document",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Enter File Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.attach_file),
              label: const Text("Choose File"),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  String filePath = result.files.single.path!;
                  controller.addFile(titleController.text, filePath);
                  Get.back();
                  Get.snackbar(
                    "Success",
                    "File uploaded successfully!",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}