import 'package:admin/panel.dart';
import 'package:flutter/material.dart';
import 'json_list.dart';
import 'json_req.dart';

void nothing(Map<String, dynamic> map) {}
class AirDrop extends StatelessWidget {
  final FunParaMap onChange;
  AirDrop(this.onChange) : super(key: UniqueKey());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getN('aircraft', reqParam: null),
        builder: (_, sh) {
          if (sh.data != null && sh.data.length != 0) {
            final jsonList = sh.data;
            final airs = <String, dynamic>{};
            jsonList.forEach((a) => airs[a['name']] = a['id']);
            return DropDown(airs, onChange,'id');
          } else {
            return DropDown({'Loading': 0}, nothing,'id');
          }
        });
  }
}

class ConfigCargoDrop extends StatelessWidget {
  final Future<List<dynamic>> future;
  final void Function(Map<String,dynamic>) onChange;
  final int initID;
  ConfigCargoDrop({@required this.future, @required this.onChange, @required this.initID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: future,
      builder: (_, sh) {
      if (sh.data != null && sh.data.length != 0) {
        final jsonList = sh.data;
        final airs = <String, dynamic>{};
        jsonList.forEach((a) => airs[a['name']] = a['cargoid']);
        return DropDown(airs, onChange,'cargoid', initID: initID,);
      } else {
        return DropDown({'Loading': 0}, nothing, 'cargoid');
      }
      });
  }
}

class DropDown extends StatefulWidget {
  final Map<String, dynamic> airs;
  final FunParaMap onChange;
  final int initID;
  final String pk;

  DropDown(this.airs, this.onChange, this.pk,{this.initID}) : super(key: UniqueKey());

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  var _dropdownMenuItems = <DropdownMenuItem<String>>[];
  String _selectedAir;
  Map<int,int> iDElementMap = {};

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(this.widget.airs);

    if(this.widget.initID != null){
      _selectedAir = _dropdownMenuItems[iDElementMap[this.widget.initID]].value;
      this.widget.onChange(<String,dynamic>{}..addEntries(this.widget.airs.entries.where((x) => x.key == this.widget.pk)));
    } else{
      _selectedAir = _dropdownMenuItems[0].value;
    }
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(
      Map<String, dynamic> airs) {
    final items = <DropdownMenuItem<String>>[];
    int element =0;
    airs.forEach((k, v) {
      iDElementMap[v] = element;
      element++;
      items.add(DropdownMenuItem(
          key: UniqueKey(),
          value: k,
          child: Text(k, style: dmDisabled),
          onTap: () {
            this.widget.onChange({k: v});
          },
        ));
    });
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
