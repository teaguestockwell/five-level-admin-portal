import 'dart:convert';

import 'package:admin/edit/aircraft.dart';
import 'package:admin/rounded_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './panel.dart';
import './json_req.dart';
import 'edit/Config.dart';
import 'edit/cargo.dart';
import 'edit/configcargo.dart';
import 'edit/glossary.dart';
import 'edit/tank.dart';
import 'edit/user.dart';
import 'json_list.dart';

class APITable extends StatefulWidget {
  final void Function() rebuildCallback;
  final String ep;
  final Map<String, String> reqParam;
  final String title;
  final int airid;
  APITable(
      {@required this.ep,
      @required this.reqParam,
      @required this.title,
      @required this.airid,
      @required this.rebuildCallback})
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
  Map<String, dynamic> editObj;
  int configIDState;

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
    if (obj.containsKey('id')) {
      this.widget.rebuildCallback();
    }
  }

  void put(Map<String, dynamic> obj) async {
    print(obj);
    final res = await put1(epState, obj);
    if (res.statusCode == 200) {
      setState(() {
        isEditing = false;
      });
      showMsg('Saved');
      if (obj.containsKey('id')) {
        this.widget.rebuildCallback();
      }
    } else {
      showMsg(jsonDecode(res.body)['msg']);
    }
  }

  void unnest() {
    if (!isEditing) {
      setState(() {
        epState = this.widget.ep;
        titleState = this.widget.title;
        reqParamState = this.widget.reqParam;
        isNested = false;
      });
    } else {
      setState(() {
        isEditing = false;
      });
    }
  }

  void createNew() {
    final baseMap = <String,dynamic>{'aircraftid': this.widget.airid};
    if (epState == 'configcargo') {
      baseMap['configid'] = configIDState;
    }

    switch (epState) {
      case 'aircraft':
        edit(Aircraft.fromJson(baseMap, put).toJson());
        break;
      case 'cargo':
        edit(Cargo.fromJson(baseMap, put).toJson());
        break;
      case 'config':
        edit(Config.fromJson(baseMap, put).toJson());
        break;
      case 'tank':
        edit(Tank.fromJson(baseMap, put).toJson());
        break;
      case 'user':
        edit(User.fromJson(baseMap, put).toJson());
        break;
      case 'glossary':
        edit(Glossary.fromJson(baseMap, put).toJson());
        break;
      case 'configcargo':
        edit(ConfigCargo.fromJson(baseMap, put).toJson());
    }
  }

  void edit(Map<String, dynamic> obj) async {
    editObj = obj;

    if (obj.containsKey('configcargos')) {
      setState(() {
        configIDState = obj['configid'];
        print(configIDState);
        epState = 'configcargo';
        titleState = obj['name'] + ' Cargos';
        reqParamState = {'configid': '${obj['configid']}'};
        isNested = true;
      });
    } else {
      setState(() {
        isEditing = true;
      });
    }
  }

  Widget getForm() {
    switch (epState) {
      case 'aircraft':
        return Aircraft.fromJson(editObj, put).getForm();
      case 'cargo':
        return Cargo.fromJson(editObj, put).getForm();
      case 'config':
        return Config.fromJson(editObj, put).getForm();
      case 'tank':
        return Tank.fromJson(editObj, put).getForm();
      case 'user':
        return User.fromJson(editObj, put).getForm();
      case 'glossary':
        return Glossary.fromJson(editObj, put).getForm();
      case 'configcargo':
        return ConfigCargo.fromJson(editObj, put).getForm();
      default:
        return Container();
    }
  }

  List<Widget> getTitle() {
    final w = 150.0;
    final h = 40.0;
    final empty = Container(width: w, height: h);

    final backButton = Container(
        width: w,
        height: h,
        child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                iconSize: 40.0,
                icon: Icon(IconData(61563, fontFamily: 'MaterialIcons')),
                onPressed: unnest)));

    final addButton = Container(
        width: w,
        height: h,
        child: BlackButton(createNew,
            text: 'New ${titleState.substring(0, titleState.length - 1)}'));

    // show back button?
    if (isNested || isEditing) {
      // modify title to singular?
      if (isEditing) {
        return [
          backButton,
          Spacer(),
          Text('Edit ${titleState.substring(0, titleState.length - 1)}',
              style: dmTitle1),
          Spacer(),
          empty
        ];
      }
      return [
        backButton,
        Spacer(),
        Text(titleState, style: dmTitle1),
        Spacer(),
        addButton
      ];
    }
    return [
      empty,
      Spacer(),
      Text(titleState, style: dmTitle1),
      Spacer(),
      addButton
    ];
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
          if (sh.data != null) {
            if (sh.data.length != 0) {
              if (!isEditing) {
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
                  Flexible(child: getForm())
                ]);
              }
            }
            if (isEditing) {
              return Column(children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(children: getTitle())),
                Flexible(child: getForm())
              ]);
            }
            return Column(children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(children: getTitle())),
              Center(
                  child: Text('No ${titleState} on this Aircraft. Add the first one. ',
                      style: dmTitle1))
            ]);
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
