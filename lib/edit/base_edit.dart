import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../panel.dart';
import '../rounded_input.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

enum InputType {
  INT,
  DOUBLE,
  STRING,
  CSV,
}

final inputkeyTypes = {
  'name': InputType.STRING,
  'role': InputType.INT,
  'fs0': InputType.DOUBLE,
  'fs1': InputType.DOUBLE,
  'mom0': InputType.DOUBLE,
  'weight0': InputType.DOUBLE,
  'weight1': InputType.DOUBLE,
  'cargoweight1': InputType.DOUBLE,
  'lemac': InputType.DOUBLE,
  'mac': InputType.DOUBLE,
  'mommultiplyer': InputType.DOUBLE,
  'body': InputType.STRING,
  'weights': InputType.CSV,
  'simplemoms': InputType.CSV,
  'weight': InputType.DOUBLE,
  'fs': InputType.DOUBLE,
  'category': InputType.INT,
  'qty': InputType.INT
};

final editableKeys = <String, Iterable<String>>{
  'user': ['name', 'role'],
  'aircraft': [
    'name',
    'fs0',
    'mom0',
    'mom1',
    'weight0',
    'weight1',
    'cargoweight1',
    'lemac',
    'mac',
    'mommultiplyer'
  ],
  'cargo': [
    'name',
    'weight',
    'fs',
    'category',
  ],
  'config': [
    'name',
  ],
  'configcargo': ['fs', 'qty'],
  'glossary': ['name', 'body'],
  'tank': ['weights', 'simplemoms']
};

class BaseEdit extends StatefulWidget {
  final Map<String, dynamic> obj;
  final String ep;
  final void Function(Map<String, dynamic>) put;
  BaseEdit(this.obj, this.ep, this.put) : super(key: UniqueKey());
  @override
  _BaseEditState createState() => _BaseEditState();
}

class _BaseEditState extends State<BaseEdit> {
  Map<String, dynamic> objState;
  final sc = ScrollController();

  @override
  void initState() {
    super.initState();
    objState = Map.from(this.widget.obj);
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  dynamic parse(String st, InputType inputT) {
    switch (inputT) {
      case InputType.CSV:
        return st;
        break;
      case InputType.INT:
        return int.parse(st);
        break;
      case InputType.DOUBLE:
        return double.parse(st);
        break;
      case InputType.STRING:
        return st;
        break;
    }
  }

  Widget getEditText(int i) {
    final key = editableKeys[this.widget.ep].elementAt(i);
    final val = objState[key];
    final inputType = inputkeyTypes[key];
    print('key: ' + key.toString());
    print('value: ' + val.toString());

    return RoundedInputField(
      height: 50.0,
      editTextBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
      textEditingController: TextEditingController(text: val.toString()),
      widthMultiplier: 0.75,
      hintText: key.toString().capitalize(),
      onChanged: (s) => objState[key] = parse(s, inputType),
    );
    // switch (inputType) {
    //   case InputType.CSV:
    //     break;
    //   case InputType.INT:
    //     break;
    //   case InputTyp.DOUBLE:
    //     break;
    //   case InputType.STRING:
    //     break;
    //   default:
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: sc,
      itemCount: editableKeys[this.widget.ep].length + 1,
      itemBuilder: (_, i) {
        if (i == 0) {
          return BlackButton(() => this.widget.put(objState));
        }
        return getEditText(i - 1);
      },
    );
  }
}
