import 'package:flutter/material.dart';
import 'Tex.dart';
import 'json_req.dart';

typedef void DeleteFunction(Map<String,dynamic> obj);

class JsonTable extends StatefulWidget {
  final List<dynamic> jsonList;
  final DeleteFunction delete;
  JsonTable(this.jsonList,this.delete);
  @override
  _JsonTableState createState() => _JsonTableState();
}

class _JsonTableState extends State<JsonTable> {


  List<DataColumn> getColumns(){

    final ret = <DataColumn>[];
    final Map<String,dynamic> jsonMap = this.widget.jsonList[0];

    jsonMap.keys.forEach((key) {
      if(!key.contains('id')){
        ret.add(DataColumn(label: Tex(key)));
      }
    });


    ret.add(DataColumn(label: Row(children: [
        Icon(IconData(59043)),
        Icon(IconData(57623))
    ])));

    return ret;
  }

  List<DataRow> getRows(){
    final ret = <DataRow>[];
    
    for(final json in this.widget.jsonList){
      final Map<String,dynamic> map = json;
      final cells = <DataCell>[];
      map.forEach((key,val){
        if(!key.contains('id')){
          cells.add(DataCell(Tex(val.toString())));
        }
      });

      cells.add(DataCell(Row(children: [
        IconButton(icon: Icon(IconData(59043)), onPressed: (){this.widget.delete(map);}),
        Icon(IconData(57623))
      ])));
      //cells.add(DataCell(IconButton(icon: Icon(IconData(59043)), onPressed: (){delete(map);},)));
        
      ret.add(DataRow(cells: cells));
    }
    return ret;
    
  }

 




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((_) => Color.fromRGBO(233,233,233,1)),
          dividerThickness: 2,
          columns: getColumns(),
          rows: getRows(),
        )
      ),
    );
  }
}



