import 'validate.dart';
import 'package:flutter/material.dart';
import '../rounded_input.dart';
import 'api_serialazable.dart';
import 'edit_text.dart';

class Config implements APISerialiable {
  int configid;
  int aircraftid;
  String name;
  void setName(String s) => name = s;
  String ep = 'config';
  void Function(Map<String, dynamic> obj) onSave;

  Config.fromJson(Map<String, dynamic> json, this.onSave)
      : configid = json["configid"] ?? 0,
        aircraftid = json["aircraftid"],
        name = json["name"] ?? '';

  Map<String, dynamic> toJson() => {
        "configid": configid,
        "aircraftid": aircraftid,
        "name": name,
      };

  Widget getForm() {
    final key = GlobalKey<FormState>();
    return Form(
        key: key,
        child: SingleChildScrollView(
            child: Column(children: [
          EditText(
              initialValue: name,
              hintText: 'Name',
              validate: (s) => validateStringNotEmpty(s, setName)),
          BlackButton(() {
            if (key.currentState.validate()) {
              this.onSave(this.toJson());
            }
          })
        ])));
  }
}
