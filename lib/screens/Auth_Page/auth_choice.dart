
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/app_routes.dart';

class auth_choice extends StatelessWidget {
  const auth_choice({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: background_design(),
          child: Column(
            children: [
              SizedBox(height: 2 * height_block),
              skip_button(context),
              SizedBox(height: 5 * height_block),
              SvgPicture.asset('assets/images/logo.svg',
                  color: Colors.black, height: height_block * 60),
              SizedBox(height: height_block * 5),
              button_style(
                "Sign In",
                context,
                function: () {
                  Navigator.pushNamed(context, app_routes.signin_screen);
                },
              ),
              const SizedBox(height: 10),
              button_style(
                "Sign Up",
                context,
                function: () {
                  Navigator.pushNamed(
                    context,
                    app_routes.signup_screen,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
