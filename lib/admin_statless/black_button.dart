import 'package:flutter/material.dart';
import '../const.dart';

class BlackButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  BlackButton(this.onPressed, {this.text = 'Save'}) : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(56, 56, 56, 1),
        ),
        child: FlatButton(
            onPressed: onPressed,
            child: Text(text, style: dmSelectedWhiteBold)));
  }
}
