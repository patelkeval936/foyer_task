
import 'package:flutter/material.dart';

List<Color> colors = [Colors.red, Colors.blue, Colors.orange, Colors.green, Colors.deepOrange, Colors.deepPurpleAccent];

List<double> listOfFontSizes = [14, 16, 18, 20, 22];

String colorToString(Color color){
  switch(color){
    case Colors.red : return 'Red';
    case Colors.blue : return 'Blue';
    case Colors.orange : return 'Orange';
    case Colors.green : return 'Green';
    case Colors.deepOrange : return 'DeepOrange';
    case Colors.deepPurpleAccent : return 'purple';
    default : return 'DeepPurple';
  }
}

Color stringToColor(String color){
  switch(color){
    case 'Red' : return Colors.red;
    case 'Blue' : return Colors.blue;
    case 'Orange' : return Colors.orange;
    case 'Green' : return Colors.green;
    case 'DeepOrange' : return Colors.deepOrange;
    case 'purple' : return Colors.deepOrangeAccent;
    default : return Colors.deepPurple;
  }
}

RegExp latitudeRegEx = RegExp(r'^(\+|-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,6})?))$');
RegExp longitudeRegEx = RegExp(r'^(\+|-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,6})?))$');
