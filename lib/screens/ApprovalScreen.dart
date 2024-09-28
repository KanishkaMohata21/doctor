import 'package:flutter/material.dart';

class ApprovalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0),  // Left and right padding of 70, top and bottom padding of 20
          child: Text(
            'Your Profile has been sent for approval, our team would reach out to you soon',
            style: TextStyle(
              fontSize: 30,  // Increased font size for better visibility
              color: Colors.black,  // Text color
              height: 1.5,  // Line height for better readability
            ),
            textAlign: TextAlign.left,  // Left align the text
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ApprovalScreen(),
  ));
}
