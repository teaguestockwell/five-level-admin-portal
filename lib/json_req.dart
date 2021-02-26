import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

final baseurl = 'http://localhost:8080/fl-api/';

/// calls the get many of an endpoint,
/// the reqParams are passed as json tp be encoded to paramaters within the Uri
Future<List<dynamic>> getN(String ep, {Map<String, String> reqParam}) async {
  String reqParamString = '?';
  Response res;

  if (reqParam != null) {
    for (int i = 0; i < reqParam.length; i++) {
      reqParamString +=
          '${reqParam.keys.elementAt(i)}=${reqParam.values.elementAt(i)}';
      if (i != reqParam.length - 1) {
        reqParamString += '&';
      }
    }

    res = await get(baseurl + ep + reqParamString);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return <dynamic>[];
    }
  } else {
    res = await get(baseurl + ep);
    if (res.statusCode == 200) {
      return compute(parseJsonIsolate, res.body);
    } else {
      return <dynamic>[];
    }
  }
}

Future<Response> delete1(String ep, Map<String, dynamic> obj) async {
  String reqParamString = '?';

  for (int i = 0; i < obj.length; i++) {
    reqParamString += '${obj.keys.elementAt(i)}=${obj.values.elementAt(i)}';
    if (i != obj.length - 1) {
      reqParamString += '&';
    }
  }

  return await delete(baseurl + ep + reqParamString);
}

List<dynamic> parseJsonIsolate(String json) {
  final ret = jsonDecode(json) as List<dynamic>;
  print('json decoded' + ret.toString());
  return ret;
}
