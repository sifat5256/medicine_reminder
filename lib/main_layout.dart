import 'package:animate_do/animate_do.dart' show FadeInDown;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/add_medicine/ui/add_medicine.dart';
import 'calender/ui/calender_screen.dart';
import 'home/ui/home_screen.dart';
import 'lay_out_controller.dart';
import 'medicine_list/ui/medicine_list.dart';
import 'profileScreen/ui/profile_screen.dart'; // Import the controller

// Dummy Screens






class BottomNavBar extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeScreen(),

    CalendarScreen(),
    MedicineList(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8E8AA3),
        title: Text(
          "Medicine Reminder",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(builder: (BuildContext context) => AddMedicine(onSave: (String , String , File? ) {  },)),
      //     // );
      //
      //
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: Obx(() => pages[navController.selectedIndex.value]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Container(
          clipBehavior: Clip.antiAlias, // Ensures border-radius is applied
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the bottom nav
            borderRadius: BorderRadius.circular(30), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Obx(
                () => BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent, // Make it match container color
              currentIndex: navController.selectedIndex.value,
              onTap: navController.changeIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                  icon: _buildNavIcon("asstes/bottom_nav_icons/house.png", 0),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: _buildNavIcon("asstes/bottom_nav_icons/calendarr.png", 1),
                  label: "Calendar",
                ),
                BottomNavigationBarItem(
                  icon: _buildNavIcon("asstes/bottom_nav_icons/pharmacy.png", 2),
                  label: "Medicine",
                ),
                BottomNavigationBarItem(
                  icon: _buildNavIcon("asstes/bottom_nav_icons/profile.png", 3),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(String assetPath, int index) {
    return Obx(
          () => ColorFiltered(
        colorFilter: ColorFilter.mode(
          navController.selectedIndex.value == index ? Colors.blue : Colors.grey,
          BlendMode.srcIn, // This changes the color of the image
        ),
        child: Image.asset(
          assetPath,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
