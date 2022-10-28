// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/app_routes.dart';

class auth_choice extends StatelessWidget {
  const auth_choice({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: background_design(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            skip_button(context),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.15),
            button_style("Sign In", context, function: () {
              Navigator.pushNamed(context, app_routes.signin_screen);
            }),
            const SizedBox(height: 10),
            button_style("Sign Up", context, function: () {
              Navigator.pushNamed(context, app_routes.signup_screen);
            }),
          ],
        ),
      ),
    );
  }
}
