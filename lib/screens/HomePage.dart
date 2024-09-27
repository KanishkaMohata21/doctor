import 'package:doctor/screens/AssesmentScreen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final List<String> patients = [
    "Patient 1",
    "Patient 2",
    "Patient 3",
    "Patient 4",
    "Patient 5",
    "Patient 6"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 247, 255), // Updated AppBar background
        elevation: 0,
        leading: Icon(Icons.search, color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Color(0xFF21005d)), // Profile icon on the AppBar
            onPressed: () {},
          ),
        ],
        title: Text(
          "Vital Step",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Adds space below the AppBar
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF21005d), // Border color matches the icon
                        width: 2.0, // Border width
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent, // Transparent background
                      child: Icon(
                        Icons.person_outline, // Outline version of the profile icon
                        size: 40,
                        color: Color(0xFF21005d), // Icon color as per your request
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hi. Operator's Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  // Add Patient Button
                  SizedBox(
                    width: 180, // Fixed width for the button
                    child: ElevatedButton(
                      onPressed: () {
                        _showAddPatientDialog(context); // Trigger dialog to add patient
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF21005d), // Button color
                      ),
                      child: Text(
                        "Add Patient",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // No rounding
                              ),
                            ),
                            onPressed: () {
                              // Navigate to AssessmentScreen when a patient is selected
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AssessmentPage(),
                                ),
                              );
                            },
                            child: Text(
                              patients[index],
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the Add Patient dialog
  void _showAddPatientDialog(BuildContext context) {
    TextEditingController _patientNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Patient"),
          content: TextField(
            controller: _patientNameController,
            decoration: InputDecoration(
              labelText: "Patient access code",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_patientNameController.text.isNotEmpty) {
                  // Add patient to the list (for now, printing it)
                  print("New patient: ${_patientNameController.text}");
                  // Close dialog
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}

