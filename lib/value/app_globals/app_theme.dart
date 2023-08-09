import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/provider/profile_provider.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) => ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: AppBarTheme(
          backgroundColor: context.watch<ProfilesProvider>().currentProfile?.themeColor ?? Colors.deepPurple,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              context.watch<ProfilesProvider>().currentProfile?.themeColor ?? Colors.deepPurple,
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: context.watch<ProfilesProvider>().currentProfile?.themeColor ?? Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 4,
          backgroundColor: context.watch<ProfilesProvider>().currentProfile?.themeColor ?? Colors.deepPurple,
        ),
      );
}
