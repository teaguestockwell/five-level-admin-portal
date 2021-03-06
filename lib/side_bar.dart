import 'package:flutter/material.dart';
import 'api_request.dart';
import 'const.dart';
import 'ep_sheet.dart';
import 'future_dropdown_button.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final menuItems = <String>[
    'Aircrafts',
    'Cargos',
    'Configs',
    'Tanks',
    'Users',
    'Glossarys'
  ];

  int airId = 1;
  int menuId = 1;
  FutureDropDownButton drop;
  int buildCount = 0;

  @override
  void initState() {
    super.initState();
    drop = FutureDropDownButton(
      onEmptyMSG: '0 Aircraft',
      future: getN('aircraft'),
      onChange: setAirState,
      apiModelPK: 'id',
    );
  }

  void panelTapped(int i) {
    setState(() => menuId = i);
  }

  void setAirState(Map<String, dynamic> newAir) {
    print(newAir.values.elementAt(0));
    setState(() => airId = newAir.values.elementAt(0));
    
  }

  void rebuild() {
    setState(() => 
      drop = FutureDropDownButton(
        onEmptyMSG: '0 Aircraft',
        future: getN('aircraft'),
        onChange: setAirState,
        apiModelPK: 'id',
      )
    );
  }

  Widget getTile(int i, double pad){
    if (i == menuId) {
      return ListTile(
        title: Padding(
          padding: EdgeInsets.only(left: pad),
          child:
              Text(menuItems[i], style: dmSelected),
        ),
        onTap: () {
          panelTapped(i);
        });
    }
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: pad),
        child: Text(menuItems[i], style: dmDisabled),
      ),
      onTap: () {
        panelTapped(i);
      });
  }

  @override
  Widget build(_) {
    buildCount++;
    return Container(
        child: Row(children: [
      Container(
          width: 250,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
              shadowColor: Colors.black.withOpacity(0.15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top:15.0),
                    child: Text('All Aircraft', style: dmTitle2),
                  ),
                  getTile(0, 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('Master Settings', style: dmTitle2),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: drop),
                  Flexible(
                    child: ListView.builder(
                        itemCount: menuItems.length-1,
                        itemBuilder: (_,i) => getTile(i+1, 15.0),
                  )
                  )
                  ,
                ],
              ))),
      Flexible(
          child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: EPSheet(
            rebuildCallback: rebuild,
            airid: airId,
            ep: endPoints[menuId],
            reqParam: {'aircraftid': airId.toString()},
            title: menuItems[menuId]
        ),
      ))
    ]));
  }
}
