import 'package:flutter/material.dart';
import 'json_list.dart';
import 'json_req.dart';
import 'tex.dart';

class AirDrop extends StatelessWidget {
  final FunParaMap onChange;
  AirDrop(this.onChange) : super(key: UniqueKey());

  void nothing(Map<String, dynamic> map) {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getN('aircraft', reqParam: null),
        builder: (_, sh) {
          if (sh.data != null && sh.data.length != 0) {
            final jsonList = sh.data;
            final airs = <String, dynamic>{};
            jsonList.forEach((a) => airs[a['name']] = a['id']);
            return DropDown(airs, onChange);
          } else {
            return DropDown({'Loading': 0}, nothing);
          }
        });
  }
}

class DropDown extends StatefulWidget {
  final Map<String, dynamic> airs;
  final FunParaMap onChange;

  DropDown(this.airs, this.onChange) : super(key: UniqueKey());

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  var _dropdownMenuItems = <DropdownMenuItem<String>>[];
  String _selectedAir;

  @override
  void initState() {
    super.initState();
    // TODO: make this not break if all aircraft are deleted
    _dropdownMenuItems = buildDropdownMenuItems(this.widget.airs);
    _selectedAir = _dropdownMenuItems[0].value;
    //this.widget.onChange({this.widget.airs.keys.elementAt(0): this.widget.airs.values.elementAt(0)});
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(
      Map<String, dynamic> airs) {
    final items = <DropdownMenuItem<String>>[];
    airs.forEach((k, v) => items.add(DropdownMenuItem(
          key: UniqueKey(),
          value: k,
          child: Tex(k),
          onTap: () {
            this.widget.onChange({k: v});
          },
        )));
    return items;
  }

  onChangeDropdownItem(String selectedAir) {
    setState(() {
      _selectedAir = selectedAir;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: DropdownButton(
        isExpanded: true,
        value: _selectedAir,
        items: _dropdownMenuItems,
        onChanged: onChangeDropdownItem,
      ),
    );
  }
}
