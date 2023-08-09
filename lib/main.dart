import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foyer/repository/repository.dart';
import 'package:foyer/utils/provider/profile_provider.dart';
import 'package:foyer/value/app_globals/app_strings.dart';
import 'package:foyer/value/app_globals/app_theme.dart';
import 'view/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Repository().openDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfilesProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(context),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
