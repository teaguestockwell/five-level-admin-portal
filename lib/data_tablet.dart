import 'dart:async';

import 'package:flutter/material.dart';
import 'tex.dart';

class DataTableT extends StatefulWidget {
  final List<Map<String, String>> jsonList;
  DataTableT(this.jsonList);
  @override
  _DataTableTState createState() => _DataTableTState();
}

class _DataTableTState extends State<DataTableT> {
  num counter = 0.0;
  Timer t;
  @override
  initState() {
    super.initState();
    t = Timer.periodic(Duration(milliseconds: 100), tick);
  }

  void tick(_) {
    counter += 100;
    if (counter % 1000 == 0) {
      print(counter);
    }
  }

  List<DataColumn> getColumns() {
    final ret = <DataColumn>[];
    final Map<String, dynamic> jsonMap = this.widget.jsonList[0];

    jsonMap.keys.forEach((key) {
      if (!key.contains('id')) {
        ret.add(DataColumn(label: Tex(key)));
      }
    });

    ret.add(DataColumn(
        label: Row(children: [Icon(IconData(59043)), Icon(IconData(57623))])));

    return ret;
  }

  List<DataRow> getRows() {
    final ret = <DataRow>[];

    for (final json in this.widget.jsonList) {
      final Map<String, dynamic> map = json;
      final cells = <DataCell>[];
      map.forEach((key, val) {
        if (!key.contains('id')) {
          cells.add(DataCell(Tex(val.toString())));
        }
      });

      cells.add(DataCell(Row(children: [
        IconButton(icon: Icon(IconData(59043)), onPressed: () {}),
        Icon(IconData(57623))
      ])));
      //cells.add(DataCell(IconButton(icon: Icon(IconData(59043)), onPressed: (){delete(map);},)));

      ret.add(DataRow(cells: cells));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: invalid_use_of_protected_member,invalid_use_of_visible_for_testing_member
      print(counter / 1000);
    });
    counter = 0.0;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                (_) => Color.fromRGBO(233, 233, 233, 1)),
            dividerThickness: 2,
            columns: getColumns(),
            rows: getRows(),
          )),
    );
  }
}
