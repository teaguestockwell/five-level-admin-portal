import 'package:admin/rounded_input.dart';
import 'package:flutter/material.dart';
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
  var search;

  @override
  void initState() {
    super.initState();

    search = RoundedInputField(
      height: 30,
      widthMultiplier: .55,
      hintText: 'Search Name',
      icon: IconData(59828, fontFamily: 'MaterialIcons'),
      onChanged: onChanged,
      editTextBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
    );
  }

  void onChanged(String text) {
    print(text);
  }

  Widget buildRow(int i) {
    final Map<String, dynamic> map = this.widget.jsonList[i];
    final strings = <String>[];

    map.forEach((key, value) {
      if (!key.contains('id')) {
        strings.add(value.toString());
      }
    });

    return getRow(strings, map: map);
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
              child: Align(alignment: Alignment.centerLeft, child: Tex(s)))));
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
    final Map<String, dynamic> map = this.widget.jsonList[0];
    final strings = <String>[];

    map.keys.forEach((key) {
      if (!key.contains('id')) {
        strings.add(key.capitalize());
      }
    });

    return Container(
      height: 58,
      child: getRow(strings),
      decoration: BoxDecoration(
          color: Color.fromRGBO(233, 233, 233, 1),
          borderRadius: BorderRadius.all(Radius.circular(3))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(padding: EdgeInsets.only(bottom: 20),child:search),
      Flexible(
        child: ListView.separated(
          itemCount: this.widget.jsonList.length + 1,
          separatorBuilder: (_, i) {
            if (i != 0) {
              return Divider(
                thickness: 2,
              );
            }
            return Container();
          },
          itemBuilder: (_, i) {
            if (i == 0) {
              return buildTitle();
            }
            return buildRow(i - 1);
          },
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
