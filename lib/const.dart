import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final dmSelected = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.bold);
final dmSelectedNormal = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.normal);

final dmSelectedWhiteBold = GoogleFonts.dmSans(
    color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold);

final dmDisabled = GoogleFonts.dmSans(
    color: Color.fromRGBO(151, 151, 151, 1),
    fontSize: 14.0,
    fontWeight: FontWeight.normal);
final dmTitle2 = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 18.0,
    fontWeight: FontWeight.bold);
final dmTitle1 = GoogleFonts.dmSans(
    color: Color.fromRGBO(56, 56, 56, 1),
    fontSize: 36.0,
    fontWeight: FontWeight.bold);
final dmbody1 = GoogleFonts.dmSans(
    color: Color.fromRGBO(51, 51, 51, 1),
    fontSize: 16.0,
    fontWeight: FontWeight.normal);

const topEPs = <String>[
  aircraftS,
  cargoS,
  configS,
  tankS,
  userS,
  glossaryS
];

// magic strings //
//please see more magic strings within the shallow model constructors

// base url for api requests
const baseurl = 'http://localhost:8080/fl-api/';

// endpoints
const aircraftS = 'aircraft';
const cargoS = 'cargo';
const configS = 'config';
const tankS = 'tank';
const userS = 'user';
const glossaryS = 'glossary';
const configCargosS = 'configcargo';

// api model primary keys
const topLvlEPPK = 'aircraftid';
const airPK = 'id';
const configCargoPK = 'configid';
const configFK = 'configcargos';

/// will be common to all modifiable models,
/// sorted alabeticly as well
const searchField = 'name';

/// keys containing this will be filterd from the json table
const rmKey = 'id';

// keys containing this will be filtered from api query strings
const rmKeyQS = 'id';

/// the font family used for icon datas
const matIcons = 'MaterialIcons';

/// http req headers
const reqHeaders = {"Content-Type": "application/json"};