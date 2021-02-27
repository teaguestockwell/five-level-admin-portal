import 'package:admin/tex.dart';
import 'package:flutter/material.dart';
import 'airdrop.dart';
import 'api_table.dart';

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
    setState(() => menuId = i);
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
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Aircraft Type',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(alignment: Alignment.centerLeft, child: drop),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Master Settings',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ListView.builder(
                          itemCount: menuItems.length,
                          itemBuilder: (_, i) {
                            return ListTile(
                                title: Tex(menuItems[i]),
                                onTap: () {
                                  panelTapped(i);
                                });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          )),
      Flexible(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: 300,
                height: 50,
                child: Center(
                    child: Text(menuItems[menuId],
                        style: TextStyle(fontFamily: 'DMSans', fontSize: 36)))),
          ),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: APITable(epS[menuId],
                    reqParam: {'aircraftid': airId.toString()}),
              )),
        ],
      ))
    ]));
  }
}
