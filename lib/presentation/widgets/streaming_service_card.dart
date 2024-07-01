import 'package:flutter/material.dart';

// Widget to display a card-like button for a streaming service
class StreamingServiceCard extends StatelessWidget {
  final String name;  // Name of the streaming service
  final String url;  // URL of the streaming service
  final VoidCallback onTap;  // Callback function when the card is tapped

  // Constructor to initialize the name, url, and onTap callback
  StreamingServiceCard({required this.name, required this.url, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),  // Vertical margin around the container
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,  // Set the background color of the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),  // Set the border radius for rounded corners
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),  // Padding inside the button
        ),
        onPressed: onTap,  // Callback when the button is pressed
        child: Text(
          name,  // Display the name of the streaming service
          style: TextStyle(
            fontSize: 16.0,  // Set the font size of the text
            fontWeight: FontWeight.bold,  // Set the font weight to bold
            color: Colors.white,  // Set the text color to white
          ),
        ),
      ),
    );
  }
}
