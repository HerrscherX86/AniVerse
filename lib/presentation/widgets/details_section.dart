import 'package:flutter/material.dart';

// Widget to display a section with a title and content
class DetailsSection extends StatelessWidget {
  final String title;  // Title of the section
  final String content;  // Content of the section

  // Constructor to initialize title and content
  DetailsSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),  // Vertical margin around the container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Align children to the start of the cross axis
        children: [
          // Title text
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 8.0),  // Space between title and content
          // Content text
          Text(
            content,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),  // Space between content and divider
          // Divider line
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}
