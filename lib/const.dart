import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle dmSelected = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.bold);
TextStyle dmSelectedNormal = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.normal);

TextStyle dmSelectedWhiteBold = GoogleFonts.dmSans(
    color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold);

TextStyle dmDisabled = GoogleFonts.dmSans(
    color: Color.fromRGBO(151, 151, 151, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.normal);
TextStyle dmTitle2 = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 18.0,
    fontWeight: FontWeight.bold);
TextStyle dmTitle1 = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 36.0,
    fontWeight: FontWeight.bold);
TextStyle dmbody1 = GoogleFonts.dmSans(
    color: Color.fromRGBO(51, 51, 51, 1),
    fontSize: 16.0,
    fontWeight: FontWeight.normal);

const endPoints = <String>[
  'aircraft',
  'cargo',
  'config',
  'tank',
  'user',
  'glossary'
];
