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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: skip_button(),
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                color: logo_brown_color,
              ),
            ),
            SizedBox(height: size.height * 0.15),
            button_style("Sign In", context, () {
              Navigator.pushNamed(context, app_routes.signin_screen);
            }),
            const SizedBox(height: 10),
            button_style("Sign Up", context, () {
              Navigator.pushNamed(context, app_routes.signout_screen);
            }),
          ],
        ),
      ),
    );
  }
}
