// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:foodora/screens/Auth_Page/Sign_In.dart';
import 'package:foodora/screens/Auth_Page/Sign_Up.dart';
import 'package:foodora/screens/Auth_Page/auth_choice.dart';
import 'package:foodora/screens/Auth_Page/email_verification_screen.dart';
import 'package:foodora/screens/Auth_Page/forgot_password_screen.dart';
import 'package:foodora/screens/Auth_Page/forget_pass_verify_screen.dart';
import 'package:foodora/screens/Auth_Page/otp_verify_screen.dart';
import 'package:foodora/screens/Home_Page/Home_Screen.dart';
import 'package:foodora/screens/Location_Page/location_screen.dart';
import 'package:foodora/screens/Splash_Screen/splash_screen.dart';
import 'error.dart';

class app_routes {
  static const splash_screen = '/splash_screen';
  static const auth_choice = '/auth_choice';
  static const signin_screen = '/signin_screen';
  static const signup_screen = '/signup_screen';
  static const home_screen = '/home_screen';
  static const location_screen = '/location_screen';
  static const forgot_password_screen = '/forgot_password_screen';
  static const forget_pass_verify_screen = '/forget_pass_verify_screen';
  static const email_verification_screen = '/email_verification_screen';
  static const otp_verify_screen = '/otp_verify_screen';
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
    case app_routes.forget_pass_verify_screen:
      final args = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => forget_pass_verify_screen(
          email: args,
        ),
      );
    case app_routes.email_verification_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const email_verification_screen(),
      );
    case app_routes.otp_verify_screen:
      final args = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => otp_verify_screen(
          email: args,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const error(),
      );
  }
}
