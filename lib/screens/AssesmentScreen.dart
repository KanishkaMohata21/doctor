import 'package:flutter/material.dart';
import 'package:doctor/screens/TestPage.dart';
import 'package:doctor/screens/Devices.dart'; // Import other required screens
import 'package:doctor/screens/AssesmentDetailsScreen.dart'; // Import other required screens
import 'package:doctor/widgets/bottomNavigationBar.dart';

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  int _selectedIndex = 0; // Default index for the navigation bar

  // Handle navigation bar tap
  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background of the whole page
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 247, 255), // AppBar background
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 4), // Add padding here
          child: Text(
            'Assessment',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.devices, color: Colors.black), // Use devices icon for computer/mobile
            onPressed: () {
              // Navigate to DeviceScreen on icon click
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Devices(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 248, 247, 252), // Background of content area
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: assessments.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to AssessmentDetailsPage on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssessmentDetailPage(),
                      ),
                    );
                  },
                  child: AssessmentTile(
                    number: index + 1,
                    title: assessments[index]['title']!,
                    details: assessments[index]['details']!,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding along the x-axis
              child: Column(
                children: [
                  // Create Assessment Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showCreateAssessmentDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 46, 39, 179), // Blue button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Create Assessment',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Add vertical gap between buttons
                  // Delete User Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the delete user action
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirm Deletion"),
                              content: Text("Are you sure you want to delete the user?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Add your delete user logic here
                                  },
                                  child: Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Rounded corners
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Delete User',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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

  final List<Map<String, String>> assessments = [
    {"title": "Weekly", "details": "sitting | 12 | Active"},
    {"title": "Monthly", "details": "sitting | 12 | Active"},
    {"title": "Daily", "details": "sitting | 12 | Active"},
  ];

  // Method to show the Create Assessment Dialog with dropdowns
  void _showCreateAssessmentDialog(BuildContext context) {
    String? selectedPosture;
    String? selectedAssessmentType;

    // Posture options
    final List<String> postures = ['Sitting', 'Standing', 'Lying Down'];

    // Assessment Type options
    final List<String> assessmentTypes = ['Weekly', 'Monthly', 'Daily'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Assessment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Posture Dropdown
              DropdownButtonFormField<String>(
                value: selectedPosture,
                decoration: InputDecoration(labelText: "Posture"),
                items: postures.map((posture) {
                  return DropdownMenuItem<String>(
                    value: posture,
                    child: Text(posture),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedPosture = newValue;
                  });
                },
              ),
              SizedBox(height: 16), // Spacing between dropdowns
              // Assessment Type Dropdown
              DropdownButtonFormField<String>(
                value: selectedAssessmentType,
                decoration: InputDecoration(labelText: "Assessment Type"),
                items: assessmentTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedAssessmentType = newValue;
                  });
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  assessments.add({
                    "title": selectedAssessmentType ?? "No Title",
                    "details": selectedPosture ?? "No Details",
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
            ElevatedButton(
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

class AssessmentTile extends StatefulWidget {
  final int number;
  final String title;
  final String details;

  AssessmentTile({
    required this.number,
    required this.title,
    required this.details,
  });

  @override
  _AssessmentTileState createState() => _AssessmentTileState();
}

class _AssessmentTileState extends State<AssessmentTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Text(
          '${widget.number}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.details),
      ),
    );
  }
}
