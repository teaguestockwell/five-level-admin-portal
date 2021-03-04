import 'package:admin/panel.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final double widthMultiplier;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final Color cursorColor;
  final Color iconColor;
  final Color editTextBackgroundColor;
  final double height;

  const RoundedInputField(
      {Key key,
      this.height,
      @required this.widthMultiplier,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.textEditingController,
      this.cursorColor,
      this.iconColor,
      this.editTextBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * widthMultiplier,
      decoration: BoxDecoration(
        color: editTextBackgroundColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        style: dmDisabled,
        controller: textEditingController,
        onChanged: onChanged,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField2 extends StatelessWidget {
  final double widthMultiplier;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final Color cursorColor;
  final Color iconColor;
  final Color editTextBackgroundColor;
  final double height;

  const RoundedInputField2(
      {Key key,
      this.height,
      @required this.widthMultiplier,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.textEditingController,
      this.cursorColor,
      this.iconColor,
      this.editTextBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * widthMultiplier,
      decoration: BoxDecoration(
        color: editTextBackgroundColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        style: dmDisabled,
        controller: textEditingController,
        onChanged: onChanged,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

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
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.15),
          //     spreadRadius: 3,
          //     blurRadius: 3,
          //     offset: Offset(0, 2), // changes position of shadow
          //   ),
          // ],
        ),
        child: FlatButton(
            onPressed: onPressed,
            child: Text(text, style: dmSelectedWhiteBold)));
  }
}
