String validateIntPositive(String s, void Function(int) setter) {
  if (s.isEmpty) {
    return 'Can not be empty';
  } else if (int.tryParse(s) == null || int.tryParse(s) < 0) {
    return 'Must be a positive integer';
  } else {
    setter(int.parse(s));
    return null;
  }
}

String validateStringNotEmpty(String s, void Function(String) setter) {
  if (s.isEmpty) {
    return 'Can not be empty';
  } else {
    setter(s);
    return null;
  }
}

String valiadateDoubleAny(String s, void Function(double) setter) {
  if (s.isEmpty) {
    return 'Can not be empty';
  } else if (double.tryParse(s) == null) {
    return 'Must be a number';
  } else {
    setter(double.parse(s));
    return null;
  }
}

String valiadateDoublePositive(String s, void Function(double) setter) {
  if (s.isEmpty) {
    return 'Can not be empty';
  } else if (double.tryParse(s) == null) {
    return 'Must be a number';

  } else if(double.tryParse(s) != null && double.tryParse(s) <= 0){
    return 'Must be a positive number';
  } else{
    setter(double.parse(s));
    return null;
  }
}

String validateOneTwoOrThree(String s, void Function(int) setter) {
  if (int.tryParse(s) == 1 || int.tryParse(s) == 2 || int.tryParse(s) == 3) {
    setter(int.parse(s));
    return null;
  } else {
    return 'Must be 1, 2, or 3';
  }
}
