import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodora',
      initialRoute: app_routes.redirector,
      onGenerateRoute: getRoute,
    );
  }
}

