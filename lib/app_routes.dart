import 'package:flutter/material.dart';
import 'package:foodora/screens/Auth_Page/Sign_In.dart';
import 'package:foodora/screens/Auth_Page/Sign_Up.dart';
import 'package:foodora/screens/Auth_Page/auth_choice.dart';
import 'package:foodora/screens/Auth_Page/email_verification_screen.dart';
import 'package:foodora/screens/Auth_Page/forgot_password_screen.dart';
import 'package:foodora/screens/Auth_Page/forget_pass_verify_screen.dart';
import 'package:foodora/screens/Auth_Page/otp_verify_screen.dart';
import 'package:foodora/screens/Home_Page/Home_Redirector.dart';
import 'package:foodora/screens/Home_Page/Search_Screen.dart';
import 'package:foodora/screens/Home_Page/about.dart';
import 'package:foodora/screens/Home_Page/food_description.dart';
import 'package:foodora/screens/Home_Page/privacy.dart';
import 'package:foodora/screens/Home_Page/profile.dart';
import 'package:foodora/screens/Home_Page/restrauntpage.dart';
import 'package:foodora/screens/Location_Page/location_screen.dart';
import 'package:foodora/screens/Location_Page/manual_location.dart';
import 'package:foodora/screens/redirector.dart';

class app_routes {
  static const auth_choice = '/auth_choice';
  static const signin_screen = '/signin_screen';
  static const signup_screen = '/signup_screen';
  static const homepage_redirector = '/homepage_redirector';
  static const location_screen = '/location_screen';
  static const forgot_password_screen = '/forgot_password_screen';
  static const forget_pass_verify_screen = '/forget_pass_verify_screen';
  static const email_verification_screen = '/email_verification_screen';
  static const otp_verify_screen = '/otp_verify_screen';
  static const redirector = '/redirector';
  static const food_description = '/food_description';
  static const profile_page = '/profile_page';
  static const restraunt_page = '/restraunt_page';
  static const search_screen = '/search_screen';
  static const privacy = '/privacy';
  static const about = '/about';
  static const manual_location = '/manual_location';
}

Route? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case app_routes.auth_choice:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const auth_choice(),
      );
      case app_routes.about:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const About(),
      );
      case app_routes.privacy:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Privacy(),
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

    case app_routes.homepage_redirector:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const homepage_redirector(),
      );
    case app_routes.location_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const location_screen(),
      );
    case app_routes.redirector:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const redirector(),
      );
    case app_routes.forgot_password_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const forgot_password_screen(),
      );
    case app_routes.manual_location:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const manual_location(),
      );
    case app_routes.profile_page:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const profile_page(),
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
    case app_routes.food_description:
      final args = settings.arguments;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => food_description(
          args: args,
        ),
      );
    case app_routes.restraunt_page:
      final args = settings.arguments;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => restraunt_page(
          restraunt_detail: args,
        ),
      );
    case app_routes.otp_verify_screen:
      final args = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => otp_verify_screen(
          email: args,
        ),
      );
    case app_routes.search_screen:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const search_screen(),
      );
    default:
      return null;
  }
}
