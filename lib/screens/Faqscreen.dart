import 'package:flutter/material.dart';
class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, // for text and icon color
        titleSpacing: 0, // Remove space between the back arrow and title
      ),
      body: ListView(
        children: <Widget>[
          buildFAQItem(
              context: context,
              question: "What is the Palm Pressure Device?",
              answer:
                  "The Palm Pressure Device is a state-of-the-art gadget designed to monitor and analyze pressure applied by the palm, providing valuable data for various applications."),
          buildFAQItem(
              context: context,
              question: "How does the Palm Pressure App work?",
              answer: "The app works by..."),
          buildFAQItem(
              context: context,
              question: "Is the device compatible with all smartphones?",
              answer: "Yes, the device is compatible with..."),
          buildFAQItem(
              context: context,
              question: "Can I use the device for gaming?",
              answer: "No, the device is not intended for gaming..."),
          buildFAQItem(
              context: context,
              question: "How do I set up the device with my phone?",
              answer: "You can set it up by..."),
          buildFAQItem(
              context: context,
              question: "What kind of support is available if I encounter issues?",
              answer: "You can reach out to..."),
          buildFAQItem(
              context: context,
              question: "Is there a warranty for the Palm Pressure Device?",
              answer: "Yes, the device comes with a..."),
          buildFAQItem(
              context: context,
              question: "Where can I download the Palm Pressure App?",
              answer: "You can download it from..."),
          buildFAQItem(
              context: context,
              question: "How do I maintain the device?",
              answer: "You can maintain the device by..."),
          buildFAQItem(
              context: context,
              question: "Can the app export data for further analysis?",
              answer: "Yes, you can export data by..."),
        ],
      ),
    );
  }

  Widget buildFAQItem({
    required BuildContext context,
    required String question,
    required String answer,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              answer,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
