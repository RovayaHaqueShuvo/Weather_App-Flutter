import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherSetting extends StatelessWidget {
  static const routeName = '/weatherSettting';
  const WeatherSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: CloseButton( onPressed: (){
            Navigator.pushNamed(context, '/');
          },)
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
