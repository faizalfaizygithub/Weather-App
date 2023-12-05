import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/homePage.dart';
import 'package:weather_app/services/location_Provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'weather app',
        home: HomePage(),
      ),
    );
  }
}
