import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/app_routes.dart';

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
      decoration: background_design(),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
        ),
      ),
    );
  }
}
