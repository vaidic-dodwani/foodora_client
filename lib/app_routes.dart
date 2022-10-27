import 'package:flutter/material.dart';
import 'package:foodora/screens/Auth_Page/Otp_Login.dart';
import 'package:foodora/screens/Auth_Page/Sign_In.dart';
import 'package:foodora/screens/Auth_Page/Sign_Up.dart';
import 'package:foodora/screens/Auth_Page/auth_choice.dart';
import 'package:foodora/screens/Auth_Page/forgot_password_screen.dart';
import 'package:foodora/screens/Home_Page/Home_Screen.dart';
import 'package:foodora/screens/Location_Page/location_screen.dart';
import 'package:foodora/screens/Splash_Screen/splash_screen.dart';
import 'error.dart';

class app_routes {
  static const splash_screen = '/splash_screen';
  static const auth_choice = '/auth_choice';
  static const signin_screen = '/signin_screen';
  static const signup_screen = '/signup_screen';
  static const otp_screen = '/otp_screen';
  static const home_screen = '/home_screen';
  static const location_screen = '/location_screen';
  static const forgot_password_screen = '/forgort_password_screen';
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
    case app_routes.signin_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const signin_screen(),
      );
    case app_routes.signup_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const signup_screen(),
      );
    case app_routes.otp_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const otp_screen(),
      );
    case app_routes.home_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const home_screen(),
      );
    case app_routes.location_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const location_screen(),
      );
    case app_routes.forgot_password_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const forgot_password_screen(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const error(),
      );
  }
}
