import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> medicines = [
    {
      'time': '08:00 AM',
      'name': 'Aspirin',
      'image': 'asstes/medicine_icon/drugs.png',
    },
    {
      'time': '11:00 AM',
      'name': 'Metronidazole',
      'image': 'asstes/medicine_icon/pills-bottle.png',
    },
    {
      'time': '05:00 PM',
      'name': 'Diphenhydramine',
      'image': 'asstes/medicine_icon/injection.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 130,
            color: Color(0xFF8E8AA3),

              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  _buildDateSelector(),
                ],
              )),
          SizedBox(height: 20),
          FadeInRight(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("9 november 2025",style: TextStyle(
                  fontSize: 24, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
            ),),

          

          SizedBox(height: 10),
          Expanded(child: _buildMedicineList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildDateSelector() {
    return FadeInLeft(
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: 70,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: index == 0 ? Color(0xFF004E98) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${5 + index}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: index == 0 ? Colors.white : Colors.black)),
                  Text("MAY",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: index == 0 ? Colors.white70 : Colors.black54)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMedicineList() {
    return ListView.builder(
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        var med = medicines[index];
        return FadeInUp(
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeIn(
                    child: Row(
                      children: [
                        Icon(Icons.watch_later_outlined,color: Colors.green,),
                        SizedBox(
                          width: 5,
                        ),
                        Text("8.00 PM",style: TextStyle(
                          fontSize: 20
                        ),),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.green,
                    thickness: 2.5,

                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: Image.asset(med['image'], height: 50),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(med['name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                        Icon(Icons.drag_indicator_outlined, color: Colors.orange, size: 28),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("150 mg , Tablet",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                        Wrap(
                          spacing: 8, // Space between items
                          runSpacing: 4, // Space between lines
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey.shade200
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Before launch",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey.shade200
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Before launch",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey.shade200
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Before launch",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            CircleAvatar(child: Icon(Icons.notifications,color: Colors.blue,))
                          ],
                        )

                      ],
                    ),

                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,

                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
