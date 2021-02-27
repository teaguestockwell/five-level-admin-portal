import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should search', () {
    // given 
    final users = <Map<String,String>>[];
    var didMach = false;

    for(int i=0; i<5000; i++){
      users.add({'name': i.toString()});
    }


    // when 
    final search = '12';
    final matches = users.map((obj){
      if(obj['name'].contains(search)){return obj;}
    });

    // then
    if(matches.length > 9){
      !didMach; 
    }

    expect(didMach,true);
  });
}