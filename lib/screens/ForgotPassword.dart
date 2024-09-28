import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  // Controller to capture the email input
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF4FF), // Light background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Forgot Password Title
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                // Email Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 5),

                // Email Input Field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your registered email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Description Text
                Text(
                  'Just enter your email & we’ll send you a temporarily password directly to your inbox so you can log in again easily.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
                SizedBox(height: 25),

                // Send Password Button
                ElevatedButton(
                  onPressed: () {
                    // Implement the forgot password functionality here
                    final email = _emailController.text;
                    print('Email entered: $email');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0101D3), // #0101D3 as button background
                    foregroundColor: Colors.white, // White text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(horizontal: 10.0), // Padding for left and right
                  ),
                  child: Text(
                    'Send Password over Email',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
