import 'package:flutter/foundation.dart';

abstract class APIRequestable {
  Map<String,dynamic> getJsonShallow();
  Map<String,dynamic> setJsonShallow();
  bool isFieldValidAtI(int i);
  bool isObjValid();
  final String description;
  final String getN;
  final String put1;
  final String delete1;
  APIRequestable({
    this.description = '',
    this.getN = '',
    this.put1 = '',
    this.delete1 = ''
  });
}

class Cargo extends APIRequestable {
  Cargo();
  @override
  Map<String, dynamic> getJsonShallow() {
    // TODO: implement getJsonShallow
    throw UnimplementedError();
  }

  @override
  bool isFieldValidAtI(int i) {
    // TODO: implement isFieldValidAtI
    throw UnimplementedError();
  }

  @override
  bool isObjValid() {
    // TODO: implement isObjValid
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> setJsonShallow() {
    // TODO: implement setJsonShallow
    throw UnimplementedError();
  }

}