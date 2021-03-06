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
    case 'aircraft': return Aircraft.fromJson(obj, put);
    case 'cargo': return Cargo.fromJson(obj, put);
    case 'config': return Config.fromJson(obj, put);
    case 'tank':return Tank.fromJson(obj, put);
    case 'user': return User.fromJson(obj, put);
    case 'glossary':return Glossary.fromJson(obj, put);
    case 'configcargo': return ConfigCargo.fromJson(obj, put);
    default: throw Exception('invalid ep passed to getAPISerializableOfEP');
  }
}