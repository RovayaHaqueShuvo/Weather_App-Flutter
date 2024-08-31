import 'package:flutter/material.dart';
import 'package:weather_app/CustomeWidgets/curved_navigatioin_bar.dart';

class AddCity extends StatelessWidget {
  const AddCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
