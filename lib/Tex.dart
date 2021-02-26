import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tex extends StatelessWidget {
  final String x;
  Tex(this.x): super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Text(
      x,
      style: TextStyle(color: Colors.black),
    );
  }
}