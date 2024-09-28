import 'package:doctor/screens/AssesmentDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/TestPage.dart';
import 'package:doctor/screens/Devices.dart';
import 'package:doctor/widgets/bottomNavigationBar.dart';

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  int _selectedIndex = 0;

  // Handle navigation bar tap
  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 247, 255),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Assessment',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.devices, color: Colors.black),
            onPressed: () {
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
            color: Color.fromARGB(255, 248, 247, 252),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient name and contact
                Text(
                  "Patient Name",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: assessments.length,
                    itemBuilder: (context, index) {
                      return AssessmentTile(
                        number: index + 1,
                        title: assessments[index]['title']!,
                        details: assessments[index]['details']!,
                        onDelete: () {
                          setState(() {
                            assessments.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // User Details Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showUserDetailsDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0101D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'User Details',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Create Assessment Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showCreateAssessmentDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 46, 39, 179),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Create Assessment',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Delete User Button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirm Deletion"),
                              content:
                                  Text("Are you sure you want to delete the user?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Add delete user logic here
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
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
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

    final List<String> postures = ['Sitting', 'Standing', 'Lying Down'];
    final List<String> assessmentTypes = ['Weekly', 'Monthly', 'Daily'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Assessment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              SizedBox(height: 16),
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

  void _showUserDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("User Details"),
          content: Text("Name: John Doe\nContact: +1 234 567 890"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
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
  final VoidCallback onDelete;

  AssessmentTile({
    required this.number,
    required this.title,
    required this.details,
    required this.onDelete,
  });

  @override
  _AssessmentTileState createState() => _AssessmentTileState();
}

class _AssessmentTileState extends State<AssessmentTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigate to AssesmentDetailsScreen when the card is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssessmentDetailPage(),
            ),
          );
        },
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
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: widget.onDelete, // Trigger delete callback
          ),
        ),
      ),
    );
  }
}
