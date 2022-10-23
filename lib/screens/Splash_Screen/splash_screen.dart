import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/colors.dart';
import 'package:foodora/screens/Auth_Page/auth_choice.dart';
import 'package:foodora/screens/app_routes.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, app_routes.auth_choice);
      },
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [background_top, background_bottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
        ),
      ),
    );
  }
}
