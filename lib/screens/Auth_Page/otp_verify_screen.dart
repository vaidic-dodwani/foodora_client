import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';

class otp_verify_screen extends StatefulWidget {
  const otp_verify_screen({super.key});

  @override
  State<otp_verify_screen> createState() => _otp_verify_screenState();
}

class _otp_verify_screenState extends State<otp_verify_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: background_design(),
          child: Column(
            children: [
              SizedBox(height: 15),
              skip_button(context),
              SizedBox(height: 10),
              SvgPicture.asset("assets/images/forget_password__vector.svg"),
              SizedBox(height: 15),
              SizedBox(
                width: size.width > 330 ? 330 : size.width - 10,
                child: Column(children: [
                  screen_heading("Forgot Password"),
                  SizedBox(height: 10),
                  screen_center_text("Please enter your Email to verify"),
                  SizedBox(height: 25),
                  form_text("EMAIL"),
                  form_field(context, "email@example.com"),
                  SizedBox(height: 50),
                  button_style("CONTINUE", context),
                ]),
              ),
              SizedBox(height: 50),
              new_user_button(context)
            ],
          ),
        ),
      ),
    );
  }
}
