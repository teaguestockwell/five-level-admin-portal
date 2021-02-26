import 'dart:convert';
import './json_req.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Tex.dart';
import 'json_table.dart';

class APITable extends StatefulWidget {
  String ep;
  Map<String,String> reqParam;
  APITable(this.ep, {this.reqParam}): super(key: UniqueKey());
  @override
  _APITableState createState() => _APITableState();
}

class _APITableState extends State<APITable> {

   void delete(Map<String,dynamic> obj)async{
    final res = await delete1(this.widget.ep, obj);
    if(res.statusCode == 200){
      setState(() {});
      showError('Deleted Succsesfully');
    } else {
      showError(jsonDecode(res.body)['msg']);
    }
  }

  void showError(String error){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Container(
              height: 200,
              child: Center(
                  child: Tex(error)
      ))));
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Center(
        child: FutureBuilder<List<dynamic>>(
          future: getN(this.widget.ep,reqParam: this.widget.reqParam),
          builder: (context,sh) {
            if(sh.data != null && sh.data.length != 0){
              List<dynamic> jsonList = sh.data;
              return JsonTable(jsonList,delete);
            } else{
              return CircularProgressIndicator();
            }
          }
        )
      )
    );
  }
}