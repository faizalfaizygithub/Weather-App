import 'package:flutter/material.dart';
import 'package:weather_app/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather app',
      theme: ThemeData(switchTheme: SwitchThemeData()),
      home: HomePage(),
    );
  }
}
