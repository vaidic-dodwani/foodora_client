import 'package:flutter/material.dart';
import 'package:foodora/screens/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodora',
      initialRoute: app_routes.splash_screen,
      onGenerateRoute: getRoute,
    );
  }
}
