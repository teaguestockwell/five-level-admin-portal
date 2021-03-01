import 'package:admin/tex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'airdrop.dart';
import 'api_table.dart';

TextStyle dmSelected = GoogleFonts.dmSans(color:Color.fromRGBO(56,56,56,1),fontSize: 14.0,fontWeight: FontWeight.bold);
TextStyle dmDisabled = GoogleFonts.dmSans(color:Color.fromRGBO(151,151,151,1),fontSize: 14.0,fontWeight: FontWeight.normal);
TextStyle dmTitle2 = GoogleFonts.dmSans(color:Color.fromRGBO(56,56,56,1),fontSize: 18.0, fontWeight: FontWeight.bold);
TextStyle dmTitle1 = GoogleFonts.dmSans(color:Color.fromRGBO(56,56,56,1),fontSize: 36.0, fontWeight: FontWeight.bold);
TextStyle dmbody1 = GoogleFonts.dmSans(color:Color.fromRGBO(51,51,51,1),fontSize: 16.0, fontWeight: FontWeight.normal);


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
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
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
                      child: Text('Aircraft Type',style: dmTitle2)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(alignment: Alignment.centerLeft, child: drop),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Master Settings',style: dmTitle2)),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ListView.builder(
                          itemCount: menuItems.length,
                          itemBuilder: (_, i) {
                            if(i == menuId){
                              return ListTile(
                                title: Text(menuItems[i], style: dmSelected),
                                onTap: () {
                                  panelTapped(i);
                                });
                            }
                            return ListTile(
                              hoverColor: Colors.amber,
                                title: Text(menuItems[i], style: dmDisabled),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: 200,
                  height: 50,
                  child: Center(
                      child: Text(menuItems[menuId],style: dmTitle1))),
            ),
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: APITable(epS[menuId],
                reqParam: {'aircraftid': airId.toString()}),
          )),
        ],
      ))
    ]));
  }
}
