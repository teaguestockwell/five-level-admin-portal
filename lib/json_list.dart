import 'package:admin/panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'rounded_input.dart';
import 'tex.dart';

typedef void FunParaMap(Map<String, dynamic> map);

class JsonList extends StatefulWidget {
  final List<dynamic> jsonList;
  final FunParaMap delete;
  final FunParaMap edit;
  final String ep;

  JsonList({
    @required this.jsonList,
    @required this.ep,
    @required this.delete,
    @required this.edit,
  }) : super(key: UniqueKey());

  @override
  _JsonListState createState() => _JsonListState();
}

class _JsonListState extends State<JsonList> {
  final sc = ScrollController();
  List<dynamic> jsonListSearched;
  List<String> goodKeys;
  var search;

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    jsonListSearched = List<dynamic>.from(this.widget.jsonList);

   filter();

    search = RoundedInputField(
      height: 30,
      widthMultiplier: .55,
      hintText: 'Search Name',
      icon: IconData(59828, fontFamily: 'MaterialIcons'),
      onChanged: onSearch,
      editTextBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
    );
  }

  void filter(){
    if(this.widget.jsonList != null && this.widget.jsonList.length > 0){
      Map<String,dynamic> map = this.widget.jsonList[0];
      final ret = <String>[];

      final keys1 = map.keys.where((k) => !k.contains('id')).toList();
      final keys2 = keys1.where((k) => map[k].toString().length < 50).toList();

      if(keys2.length > 5){
        goodKeys = keys2.sublist(0,5);
      } else{
        goodKeys = keys2;
      }
    }
  }

  void onSearch(String text) {
    if(text.isEmpty){
      setState(()=>jsonListSearched = List<dynamic>.from(this.widget.jsonList));
    } else{
      setState(()=> jsonListSearched = this.widget.jsonList.where((x) => x['name'].toUpperCase().contains(text.toUpperCase())).toList());
    }
  }

  Widget buildRow(int i) {
    final Map<String, dynamic> map = jsonListSearched[i];
    final values = goodKeys.map((k) => map[k].toString()).toList();
    return getRow(values, map: map);
  }

  Widget getRow(List<String> strings, {Map<String, dynamic> map}) {
    final ret = <Widget>[];
    strings.forEach((s) {
      ret.add(Spacer());

      ret.add(Expanded(
          flex: 5,
          child: Container(
              width: 25,
              height: 60,
              child: Align(alignment: Alignment.centerLeft, child: Text(s.capitalize(), style: dmbody1)))));
    });

    if (map != null) {
      ret.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
            width: 25,
            height: 35,
            child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    icon: Icon(IconData(59043, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      this.widget.delete(map);
                    }))),
      ));

      ret.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
            width: 25,
            height: 35,
            child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    icon: Icon(IconData(57623, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      this.widget.edit(map);
                    }))),
      ));
    } else {
      ret.add(Container(width: 25));
      ret.add(Container(width: 25));
    }
    ret.add(Spacer());
    return Row(children: ret);
  }

  Widget buildTitle() {
    return Container(
      height: 58,
      child: getRow(goodKeys),
      decoration: BoxDecoration(
          color: Color.fromRGBO(233, 233, 233, 1),
          borderRadius: BorderRadius.all(Radius.circular(3))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: search
      ),

      buildTitle(),

      Flexible(
        child: CupertinoScrollbar(
          thickness: 5,
          controller: sc,
          isAlwaysShown: true,
          child: ListView.separated(
            controller: sc,
            itemCount: jsonListSearched.length,
            itemBuilder: (_, i) => buildRow(i),
            separatorBuilder: (_, x) => Divider(
              thickness: 2,
            ),
          ),
        ),
      )
    ]);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
