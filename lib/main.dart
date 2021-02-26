import 'package:flutter/material.dart';

import './api_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Map<String,String>> getMaps(){
    final ret = <Map<String,String>>[];
    for(int i=0;i<5000; i++){
      ret.add(<String,String>{});
      for(int k=0; k< 2; k++){
        ret[i][k.toString()] = k.toString();
      }
     }
     print('done');
     return ret;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: APITable('cargo', reqParam: {'aircraftid': '1'}))
    );
  }
}
