import 'dart:async';

import 'package:admin/edit/aircraft.dart';
import 'package:admin/edit/configcargo.dart';
import 'package:admin/edit/glossary.dart';
import 'package:admin/edit/user.dart';
import 'package:admin/panel.dart';
import 'package:admin/rounded_input.dart';
import 'package:flutter/material.dart';
import 'airdrop.dart';
import 'edit/cargo.dart';
import 'edit/edit_text.dart';
import 'edit/tank.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: 
            AdminPanel()
            //Center(child: Aircraft.fromJson({'aircraftid': 1}, (x){print(x.toString());}).getForm())
            //Center(child:AirDrop(onTap))
        ));
  }
}