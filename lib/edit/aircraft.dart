import 'package:admin/edit/validate.dart';
import 'package:flutter/material.dart';

import '../rounded_input.dart';
import 'edit_text.dart';

class Aircraft {
    int id;
    String name; void setName(String s) => name=s;
    double fs0; void setFs0(double s) => fs0=s;
    double fs1; void setFs1(double s) => fs1=s;
    double mom0; void setMom0(double s) => mom0=s;
    double mom1; void setMom1(double s) => mom1=s;
    double weight0; void setWeight0(double s) => weight0=s;
    double weight1; void setWeight1(double s) => weight1=s;
    double cargoweight1; void setCargoWeight1(double s) => cargoweight1=s;
    double lemac; void setLemac(double s) => lemac=s;
    double mac; void setMac(double s) => mac=s;
    double mommultiplyer; void setMomMultiplyer(double s) => mommultiplyer=s;
    void Function(Map<String,dynamic>) onSave;

    Aircraft.fromJson(Map<String, dynamic> json, this.onSave):
        id = json["id"] ?? 0,
        name = json["name"] ?? '',
        fs0 = json["fs0"] ?? -1.0,
        fs1 = json["fs1"] ?? -1.0,
        mom0 = json["mom0"] ?? -1.0,
        mom1 = json["mom1"] ?? -1.0,
        weight0 = json["weight0"] ?? -1.0,
        weight1 = json["weight1"] ?? -1.0,
        cargoweight1 = json["cargoweight1"] ?? -1.0,
        lemac = json["lemac"] ?? -1.0,
        mac = json["mac"] ?? -1.0,
        mommultiplyer = json["mommultiplyer"] ?? -1.0;

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fs0": fs0,
        "fs1": fs1,
        "mom0": mom0,
        "mom1": mom1,
        "weight0": weight0,
        "weight1": weight1,
        "cargoweight1": cargoweight1,
        "lemac": lemac,
        'mac': mac,
        'mommultiplyer': mommultiplyer,
    };

    Widget getForm(){
         final key = GlobalKey<FormState>();
    return Form(
      key: key,
      child: SingleChildScrollView(child: Column(
        children: [

          EditText(
            initialValue: name,
            hintText: 'Name',
            validate: (s) => validateStringNotEmpty(s,setName)
          ),

           EditText(
            initialValue: fs0.toString(),
            hintText: 'Min Fuselage Station',
            validate: (s) => valiadateDoubleAny(s,setFs0)
          ),

          EditText(
            initialValue: fs1.toString(),
            hintText: 'Max Fuselage Station',
            validate: (s) => valiadateDoubleAny(s,setFs1)
          ),

           EditText(
            initialValue: mom0.toString(),
            hintText: 'Min Simple Moment',
            validate: (s) => valiadateDoubleAny(s,setMom0)
          ),

          EditText(
            initialValue: mom1.toString(),
            hintText: 'Max Simple Moment',
            validate: (s) => valiadateDoubleAny(s,setMom1)
          ),

           EditText(
            initialValue: weight0.toString(),
            hintText: 'Min Basic Weight',
            validate: (s) => valiadateDoubleAny(s,setWeight0)
          ),

           EditText(
            initialValue: weight1.toString(),
            hintText: 'Max Basic Weight',
            validate: (s) => valiadateDoubleAny(s,setWeight1)
          ),

           EditText(
            initialValue: cargoweight1.toString(),
            hintText: 'Max individual cargo weight',
            validate: (s) => valiadateDoubleAny(s,setCargoWeight1)
          ),

           EditText(
            initialValue: lemac.toString(),
            hintText: 'LEMAC',
            validate: (s) => valiadateDoubleAny(s,setLemac)
          ),

           EditText(
            initialValue: mac.toString(),
            hintText: 'MAC',
            validate: (s) => valiadateDoubleAny(s,setMac)
          ),

           EditText(
            initialValue: mommultiplyer.toString(),
            hintText: '"x" where: simple moment = moment / x',
            validate: (s) => valiadateDoubleAny(s,setMomMultiplyer)
          ),

          BlackButton(
            () { 
              print(key.currentState.validate());
              if(key.currentState.validate()){
              this.onSave(this.toJson());
            }}
          )
        ]
      ))
    );
    }
}