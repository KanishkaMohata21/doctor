import 'package:flutter/material.dart';
import 'ProfileScreen.dart'; // Import ProfileScreen

class Devices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 247, 255, 1), // Custom background color
      appBar: AppBar(
        title: Center(child: Text('VITAL STEP')),
        automaticallyImplyLeading: true, // Re-enabling back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button functionality here
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to ProfileScreen on icon click
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 24.0, right: 24.0), // Different padding for all directions
        child: Column(
          children: [
            // Part 1: Existing Devices (40% of height)
            Expanded(
              flex: 4, // 40% of screen height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Existing Devices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    leading: Text('1'),
                    title: Text('Home'),
                    subtitle: Text('dab77f6e-83fe-4942-acc8-e3b0a1b95d86'),
                  ),
                ],
              ),
            ),
            // Part 2: Add Device (60% of height)
            Expanded(
              flex: 6, // 60% of screen height
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Device',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(238, 238, 238, 1), // Input field background color
                        labelText: 'Device Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(238, 238, 238, 1), // Input field background color
                        labelText: 'Device Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Save Device'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color.fromRGBO(238, 238, 238, 1), // Same background color as input
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Reduced button radius
                        ),
                        foregroundColor: Colors.black, // Text color to black
                      ),
                    ),
                    SizedBox(height: 30.0), // Added a large space between Save Device and Submit buttons
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color.fromRGBO(238, 238, 238, 1), // Same background color as input
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Reduced button radius
                        ),
                        foregroundColor: Colors.black, // Text color to black
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
