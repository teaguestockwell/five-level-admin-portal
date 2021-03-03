import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './panel.dart';
import './json_req.dart';
import 'edit/base_edit.dart';
import 'json_list.dart';

class APITable extends StatefulWidget {
  final String ep;
  final Map<String, String> reqParam;
  final String title;
  APITable({@required this.ep, @required this.reqParam, @required this.title})
      : super(key: UniqueKey());
  @override
  _APITableState createState() => _APITableState();
}

class _APITableState extends State<APITable> {
  String epState;
  String titleState;
  Map<String, String> reqParamState;
  var isNested = false;
  bool isEditing = false;
  Map<String,dynamic> editObj;

  @override
  void initState() {
    super.initState();
    epState = this.widget.ep;
    titleState = this.widget.title;
    reqParamState = this.widget.reqParam;
  }

  void delete(Map<String, dynamic> obj) async {
    final res = await delete1(epState, obj);
    if (res.statusCode == 200) {
      setState(() {});
      showMsg('Deleted');
    } else {
      showMsg(jsonDecode(res.body)['msg']);
    }
  }

  void put(Map<String,dynamic> obj) async {
    final res = await put1(epState, obj);
    if (res.statusCode == 200) {
      setState(() {
        isEditing = false;
      });
      showMsg('Saved');
    } else {
      showMsg(jsonDecode(res.body)['msg']);
    }
  }

  void unnest() {
    if(!isEditing){
      setState(() {
        epState = this.widget.ep;
        titleState = this.widget.title;
        reqParamState = this.widget.reqParam;
        isNested = false;
      });
    }
    else{
      setState((){
      isEditing = false;
      });
    }
  }

  void edit(Map<String, dynamic> obj) async {
    print(obj);

    final isConfig = obj.containsKey('configcargos');

    if (isConfig) {
      setState(() {
        epState = 'configcargo';
        titleState = obj['name'] + ' Cargos';
        reqParamState = {'configid': '${obj['configid']}'};
        isNested = true;
      });
    } else {
      print('notnested');
      setState(() {
        isEditing = true;
        editObj = obj;
      });
      
    }
  }

  void back() {}

  List<Widget> getTitle() {
    if (isNested || isEditing) {
      if(isEditing){
        return [
          IconButton(
              iconSize: 40.0,
              icon: Icon(IconData(61563, fontFamily: 'MaterialIcons')),
              onPressed: unnest),
          Spacer(flex: 10),
          Text('Edit ${titleState.substring(0,titleState.length-1)}', style: dmTitle1),
          Spacer(flex: 11),
        ];
      } else{
        return [
          IconButton(
              iconSize: 40.0,
              icon: Icon(IconData(61563, fontFamily: 'MaterialIcons')),
              onPressed: unnest),
          Spacer(flex: 10),
          Text(titleState, style: dmTitle1),
          Spacer(flex: 11),
        ];
      }
    } else {
      return [
        Spacer(),
        Text(titleState, style: dmTitle1),
        Spacer(),
      ];
    }
  }

  void showMsg(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 4,
        backgroundColor: Color.fromRGBO(233, 233, 233, 1),
        content: Container(
            height: 200, child: Center(child: Text(error, style: dmbody1)))));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        key: UniqueKey(),
        future: getN(epState, reqParam: reqParamState),
        builder: (context, sh) {
          if (sh.data != null && sh.data.length != 0) {
            if(!isEditing){
            List<dynamic> jsonList = sh.data;
            return Column(children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(children: getTitle())),
              Flexible(
                child: JsonList(
                    jsonList: jsonList,
                    ep: epState,
                    delete: delete,
                    edit: edit),
              )
            ]);
            } else {
              return Column(children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(children: getTitle())),
              Flexible(
                child: BaseEdit(editObj, epState, put)
              )
            ]);
            }
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(titleState, style: dmTitle1)),
                ),
                CircularProgressIndicator(),
              ],
            );
          }
        });
  }
}
