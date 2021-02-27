import 'dart:async';

import 'package:admin/panel.dart';
import 'package:admin/rounded_input.dart';
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
        home: Scaffold(body: 
      AdminPanel()
        //Test()
            //Center(child:AirDrop(onTap))
            ));
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final users = <Map<String,String>>[];
  num counter = 0.0;
  Timer t;
  Widget search;

  @override
  void initState(){
    super.initState();

    t = Timer.periodic(Duration(milliseconds: 100), (_)=> counter+=100);

    // given 
    for(int i=0; i<50000; i++){
      users.add({'name': i.toString()});
    }
    
    search = RoundedInputField(
      height: 30,
      widthMultiplier: .55,
      hintText: 'Search Name',
      icon: IconData(59828, fontFamily: 'MaterialIcons'),
      onChanged: onSearch,
      editTextBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
    );

    print(users);

  }

  void onSearch(String text){
    print('searching for ' +text);
    counter = 0;
    print('counter reset to: ' + counter.toString());

    final found = users.where((u) => u['name'].contains(text));

    print(counter);
    print(found.length);
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(child: search);
  }
}
