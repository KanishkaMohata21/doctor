import 'package:doctor/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  String? _gender;
  String? _dominantHand;

  // Define focus nodes
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode countryCodeFocusNode = FocusNode();
  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode pincodeFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode palmLengthFocusNode = FocusNode();
  final FocusNode palmWidthFocusNode = FocusNode();
  final FocusNode knucklesLengthFocusNode = FocusNode();
  final FocusNode heightFocusNode = FocusNode();
  final FocusNode weightFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode dominantHandFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose of focus nodes when not needed to prevent memory leaks
    nameFocusNode.dispose();
    countryCodeFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    addressFocusNode.dispose();
    cityFocusNode.dispose();
    pincodeFocusNode.dispose();
    countryFocusNode.dispose();
    dobFocusNode.dispose();
    palmLengthFocusNode.dispose();
    palmWidthFocusNode.dispose();
    knucklesLengthFocusNode.dispose();
    heightFocusNode.dispose();
    weightFocusNode.dispose();
    genderFocusNode.dispose();
    dominantHandFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Disable the scroll bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  'VITAL STEP',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Name
              buildTextField('Name [Required]', nameFocusNode),
              SizedBox(height: 15),
              // Country Code
              buildTextField('Country Code [Required]', countryCodeFocusNode),
              SizedBox(height: 15),
              // Mobile Number
              buildTextField('Mobile Number [Required]', mobileNumberFocusNode),
              SizedBox(height: 15),
              // Email
              buildTextField('Email [Required]', emailFocusNode),
              SizedBox(height: 15),
              // Password
              buildTextField(
                'Password [Required]',
                passwordFocusNode,
                obscureText: _obscureText,
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
              SizedBox(height: 15),
              // Address
              buildTextField('Address', addressFocusNode),
              SizedBox(height: 15),
              // City
              buildTextField('City', cityFocusNode),
              SizedBox(height: 15),
              // Pincode
              buildTextField('Pincode', pincodeFocusNode),
              SizedBox(height: 15),
              // Country
              buildTextField('Country', countryFocusNode),
              SizedBox(height: 15),
              // Date of Birth
              buildTextField('Date of Birth [Required]', dobFocusNode),
              SizedBox(height: 15),
              // Additional Fields
              buildTextField('Palm Length (cm)', palmLengthFocusNode),
              SizedBox(height: 15),
              buildTextField('Palm Width (cm)', palmWidthFocusNode),
              SizedBox(height: 15),
              buildTextField('Knuckles Length (cm)', knucklesLengthFocusNode),
              SizedBox(height: 15),
              buildTextField('Height in CM [Required]', heightFocusNode),
              SizedBox(height: 15),
              buildTextField('Weight in KG [Required]', weightFocusNode),
              SizedBox(height: 15),
              // Gender and Dominant Hand
              Row(
                children: [
                  Expanded(
                    child: buildDropdownField(
                      'Gender [Required]',
                      genderFocusNode,
                      (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                      ['Male', 'Female', 'Prefer not to say', 'Other'],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildDropdownField(
                      'Dominant Hand [Required]',
                      dominantHandFocusNode,
                      (value) {
                        setState(() {
                          _dominantHand = value;
                        });
                      },
                      ['Left', 'Right'],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Text('I accept the '),
                  GestureDetector(
                    onTap: () {
                      // Terms and conditions action
                    },
                    child: Text(
                      'terms and conditions',
                      style: TextStyle(
                        color: Color.fromRGBO(44, 40, 177, 1),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign up action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(44, 40, 177, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color.fromRGBO(44, 40, 177, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, FocusNode focusNode,
      {bool obscureText = false, Widget? suffixIcon}) {
    return Focus(
      focusNode: focusNode,
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(
                color: isFocused
                    ? Color.fromRGBO(44, 40, 177, 1) // Change color when focused
                    : Colors.black, // Initial color
              ),
              filled: true,
              fillColor: Color.fromRGBO(242, 242, 242, 1),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          );
        },
      ),
    );
  }

  Widget buildDropdownField(
    String label,
    FocusNode focusNode,
    ValueChanged<String?> onChanged,
    List<String> items,
  ) {
    return Focus(
      focusNode: focusNode,
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return DropdownButtonFormField<String>(
            value: null, // Set to an initial value if needed
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: isFocused
                    ? Color.fromRGBO(44, 40, 177, 1) // Change color when focused
                    : Colors.black, // Initial color
              ),
              filled: true,
              fillColor: Color.fromRGBO(242, 242, 242, 1),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          );
        },
      ),
    );
  }
}
