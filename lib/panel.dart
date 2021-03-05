import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'airdrop.dart';
import 'api_table.dart';

TextStyle dmSelected = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.bold);
TextStyle dmSelectedNormal = GoogleFonts.dmSans(
color: Color.fromRGBO(56, 56, 56, 1),
fontSize: 14.0,
fontWeight: FontWeight.normal);

TextStyle dmSelectedWhiteBold = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.bold);

TextStyle dmDisabled = GoogleFonts.dmSans(
    color: Color.fromRGBO(151, 151, 151, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.normal);
TextStyle dmTitle2 = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 18.0,
    fontWeight: FontWeight.bold);
TextStyle dmTitle1 = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 36.0,
    fontWeight: FontWeight.bold);
TextStyle dmbody1 = GoogleFonts.dmSans(
    color: Color.fromRGBO(51, 51, 51, 1),
    fontSize: 16.0,
    fontWeight: FontWeight.normal);

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final menuItems = <String>[
    // this extra space is important becaue all other elements have last
    // element of string removed dynamiclly because thay are plural
    'Basic Data ',
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
  int airId = 1;
  int menuId = 1;
  AirDrop drop;

  @override
  void initState() {
    super.initState();
    drop = AirDrop(setAirState);
  }

  

  void panelTapped(int i) {
    setState(() => menuId = i);
  }

  void setAirState(Map<String, dynamic> newAir) {
    print(newAir.values.elementAt(0));
    setState(() => airId = newAir.values.elementAt(0));
  }

  void rebuild(){
    setState(() => drop = AirDrop(setAirState));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
      Container(
          //color: Colors.white,
          decoration: BoxDecoration(
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
          child: Material(
            shadowColor: Colors.black.withOpacity(0.15),
            child:Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Aircraft Type', style: dmTitle2),
                ),
                
                Padding(
                  padding: EdgeInsets.only(left: 30, right:30),
                  child: drop
                )
                ,
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Master Settings', style: dmTitle2),
                ),

                Flexible(
                  child: ListView.builder(
                      itemCount: menuItems.length,
                      itemBuilder: (_, i) {
                        if (i == menuId) {
                          return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(menuItems[i], style: dmSelected),
                              ),
                              onTap: () {
                                panelTapped(i);
                              });
                        }
                        return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(menuItems[i], style: dmDisabled),
                            ),
                            onTap: () {
                              panelTapped(i);
                            });
                      }),
                ),
              ],
            ),
          ))),
      Flexible(
          child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: APITable(
            rebuildCallback: rebuild,
            airid: airId,
            ep: epS[menuId],
            reqParam: {'aircraftid': airId.toString()},
            title: menuItems[menuId]),
      ))
    ]));
  }
}
