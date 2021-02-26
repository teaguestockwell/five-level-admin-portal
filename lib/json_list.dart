import 'package:flutter/material.dart';
import 'Tex.dart';

class JsonList extends StatefulWidget {
  final List<dynamic> jsonList;
  final String deleteEp;
  final String putEp;
  JsonList(this.jsonList,this.deleteEp, this.putEp): super(key: UniqueKey());
  @override
  _JsonListState createState() => _JsonListState();
}

class _JsonListState extends State<JsonList> {
  Widget buildRow(int i){
    final Map<String,dynamic> map = this.widget.jsonList[i];
    final cells = <Widget>[];

    map.forEach((key, value){
      if(!key.contains('id')){
        cells.add(Spacer());
        cells.add(Tex(value.toString()));
      }
    });

    cells.add(Spacer());

    return Row(children: cells);
  }

  Widget buildTitle(){
    final Map<String,dynamic> map = this.widget.jsonList[0];
    final titles = <Widget>[];

    map.keys.forEach((key){
      if(!key.contains('id')){
        titles.add(Spacer());
        titles.add(Tex(key));
      }
    });

    titles.add(Spacer());

    return Row(children: titles);
  }

  @override
  Widget build(BuildContext context) {
    return
    ListView.separated(
      itemCount: this.widget.jsonList.length + 1,
      separatorBuilder: (_,i) => Divider(),
      itemBuilder: (_,i) {
        if(i == 0){return buildTitle();}
        return buildRow(i-1);
      },
    );
  }
}