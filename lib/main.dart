import './api_table.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: APITable('cargo',reqParam: {'aircraftid':'1'})
      )
    );
  }
}
