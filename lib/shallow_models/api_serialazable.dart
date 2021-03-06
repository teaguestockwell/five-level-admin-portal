import 'package:admin/const.dart';
import 'package:flutter/material.dart';
import 'aircraft.dart';
import 'cargo.dart';
import 'config.dart';
import 'configcargo.dart';
import 'glossary.dart';
import 'tank.dart';
import 'user.dart';

abstract class APISerialiable {
  String ep;
  void Function(Map<String, dynamic> obj) onSave;
  Map<String, dynamic> toJson();
  Widget getForm();
}

APISerialiable getAPISerializableOfEP({
  @required String ep,
  @required Map<String,dynamic> obj,
  @required void Function(Map<String,dynamic>) put
}){
  switch (ep) {
    case aircraftS: return Aircraft.fromJson(obj, put);
    case cargoS: return Cargo.fromJson(obj, put);
    case configS: return Config.fromJson(obj, put);
    case tankS:return Tank.fromJson(obj, put);
    case userS: return User.fromJson(obj, put);
    case glossaryS:return Glossary.fromJson(obj, put);
    case configCargosS: return ConfigCargo.fromJson(obj, put);
    default: throw Exception('invalid ep passed to getAPISerializableOfEP');
  }
}