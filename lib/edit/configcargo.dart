import 'package:admin/edit/validate.dart';
import 'package:flutter/material.dart';

import '../rounded_input.dart';
import 'api_serialazable.dart';
import 'edit_text.dart';

class ConfigCargo implements APISerialiable {
  int configid;
  int aircraftid;
  int cargoid;
  int configcargoid;
  double fs;
  void setFS(double s) => fs = s;
  int qty;
  void setQty(int s) => qty = s;
  String name;
  String ep = 'configcargo';
  void Function(Map<String, dynamic> obj) onSave;

  ConfigCargo.fromJson(Map<String, dynamic> json, this.onSave)
      : configid = json["configid"] ?? 0,
        aircraftid = json["aircraftid"],
        cargoid = json["cargoid"],
        configcargoid = json["configcargoid"] ?? 0,
        fs = json["fs"] ?? -1,
        qty = json["qty"] ?? 1,
        name = json["name"] ?? '';

  Map<String, dynamic> toJson() => {
        "configid": configid,
        "aircraftid": aircraftid,
        "cargoid": cargoid,
        "configcargoid": configcargoid,
        "fs": fs,
        "qty": qty,
        "name": name,
      };

  Widget getForm() {
    final key = GlobalKey<FormState>();
    return Form(
        key: key,
        child: SingleChildScrollView(
            child: Column(children: [
          EditText(
              initialValue: fs.toString(),
              hintText: 'Fuselage Station',
              validate: (s) => valiadateDoubleAny(s, setFS)),
          EditText(
              initialValue: qty.toString(),
              hintText: 'Quantity',
              validate: (s) => validateIntPositive(s, setQty)),
          BlackButton(() {
            if (key.currentState.validate()) {
              this.onSave(this.toJson());
            }
          })
        ])));
  }
}
