import 'package:admin/tex.dart';
import 'package:flutter/material.dart';
import 'airdrop.dart';
import 'api_table.dart';
import 'json_list.dart';
import 'json_req.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final menuItems = <String>[
    'General',
    'Cargos',
    'Configs',
    'Tanks',
    'Users',
    'Glossarys'
  ];
  final epS = <String>[
    'aircraft',
    'cargo',
    'config',
    'tank',
    'user',
    'glossary'
  ];
  AirDrop drop;
  int airId = 1;
  int menuId = 1;

  @override
  void initState() {
    super.initState();
    drop = AirDrop(airChange);
  }

  void panelTapped(int i) {
    setState(() => menuId = i - 1);
  }

  void airChange(Map<String, dynamic> newAir) {
    print(newAir.values.elementAt(0));
    setState(() => airId = newAir.values.elementAt(0));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      Container(
          width: 150,
          child: ListView.builder(
              itemCount: menuItems.length + 1,
              itemBuilder: (_, i) {
                if (i == 0) {
                  return drop;
                }
                return ListTile(
                    title: Tex(menuItems[i - 1]),
                    onTap: () {
                      panelTapped(i);
                    });
              })),
      Flexible(
          child:
              APITable(epS[menuId], reqParam: {'aircraftid': airId.toString()}))
    ]));
  }
}
