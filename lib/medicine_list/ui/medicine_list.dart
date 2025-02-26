import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:medicine_reminder/add_reminder/ui/add_reminder.dart';
import '../../add_medicine/ui/add_medicine.dart';
// Import the MedicineDetail screen

class MedicineList extends StatefulWidget {
  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<Map<String, dynamic>> items = [];

  void _addItem(String title, String description, File? image) {
    setState(() {
      items.add({"title": title, "description": description, "image": image});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.isEmpty
          ? Center(child: Text("No items added"))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FadeInDown(
            child: Container(
              child: ListTile(
                title: Text(items[index]['title']),
                subtitle: Text(items[index]['description']),
                leading: items[index]['image'] != null
                    ? Image.file(
                  items[index]['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.image),
                onTap: () {
                  // Navigate to the detail screen and pass the item data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReminderScreen(
                        item: items[index], // Pass the selected item
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMedicine(onSave: _addItem),
          ),
        ),
      ),
    );
  }
}
