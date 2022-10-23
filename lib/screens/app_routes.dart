import 'package:flutter/material.dart';
import 'package:foodora/screens/Auth_Page/auth_choice.dart';
import 'package:foodora/screens/Splash_Screen/splash_screen.dart';
import 'package:foodora/screens/error.dart';

class app_routes {
  static const splash_screen = '/splash_screen';
  static const auth_choice = '/auth_choice';
}

Route getRoute(RouteSettings settings) {
  switch (settings.name) {
    case app_routes.splash_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const splash_screen(),
      );

    case app_routes.auth_choice:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const auth_choice(),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const error(),
      );
  }
}
