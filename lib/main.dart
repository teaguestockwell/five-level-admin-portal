import 'package:admin/panel.dart';
import 'package:flutter/material.dart';
import './api_table.dart';
import 'airdrop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void onTap(Map<String, dynamic> map) {
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: AdminPanel()
            //Center(child:AirDrop(onTap))
            ));
  }
}
