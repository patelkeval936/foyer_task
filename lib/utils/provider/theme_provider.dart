import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

   Color themeColor = Colors.red;
   double fontSize = 14;

  Future<void> updateFontSize(double size) async {
    fontSize = size;
    print('font size is $fontSize');
    notifyListeners();
  }

  void updateThemeColor(Color color) async {
    themeColor = color;
    print('theme color is $themeColor');
    notifyListeners();
  }
}
