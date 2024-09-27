import 'package:doctor/screens/SignUpScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String? _selectedRole; // To store the selected role (Patient or Doctor)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,    // Padding for the top
          bottom: 20, // Padding for the bottom
          left: 12,   // Padding for the left
          right: 12,  // Padding for the right
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'VITAL STEP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // Login text color
              ),
            ),
            SizedBox(height: 50), // Increased space between ANTRIKSH and the form
            // Dropdown for selecting role
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login As',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Label color
                ),
              ),
            ),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              hint: Text('Select Role'),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(242, 242, 242, 1),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              ),
              items: <String>['Patient', 'Doctor'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
            ),
                        SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Label color
                ),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(242, 242, 242, 1), // Background color for input fields
                hintText: 'Email',
                border: InputBorder.none, // No border for input fields
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12), // Add left space
              ),
            ),
            SizedBox(height: 20),
            // Password Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Label color
                ),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(242, 242, 242, 1), // Background color for input fields
                hintText: 'Password',
                border: InputBorder.none, // No border for input fields
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12), // Add left space
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle login action
                  // You can also use _selectedRole here to perform role-specific actions
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(44, 40, 177, 1), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white), // Login button text color
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot Password ? '),
                GestureDetector(
                  onTap: () {
                    // Handle reset password action
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Color.fromRGBO(44, 40, 177, 1), // Text color for reset password
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New User? '),
                GestureDetector(
                  onTap: () {
                    // Navigate to SignUpScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color.fromRGBO(44, 40, 177, 1), // Text color for sign up
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
