import 'package:flutter/material.dart';

abstract class APISerialiable{
  String ep;
  void Function(Map<String,dynamic> obj) onSave;
  Map<String,dynamic> toJson();
  Widget getForm();
}