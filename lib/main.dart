import 'package:doctor/screens/HomePage.dart';
import 'package:doctor/screens/LoginScreen.dart';
import 'package:doctor/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: SafeArea(
        child: CustomBottomNavigationBar(), // Wrap with SafeArea
      ),
    );
  }
}