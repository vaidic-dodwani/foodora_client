import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/designing.dart';

class otp_screen extends StatefulWidget {
  const otp_screen({super.key});

  @override
  State<otp_screen> createState() => _otp_screenState();
}

class _otp_screenState extends State<otp_screen> {
  bool _otp_entered = false;
  bool _phone_number_entered = false;

  bool? _full_Otp;

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
              SizedBox(height: 10),
              skip_button(context),
              SizedBox(height: 30),

              SvgPicture.asset("assets/images/sign_in_vector.svg"),
              SizedBox(height: size.height * 0.075),
              _otp_entered && _phone_number_entered
                  ? otp_input(context, _full_Otp,
                      otp_controller_function: (pin) {
                      if (pin.toString().isEmpty) {
                        _full_Otp = null;
                      } else {
                        pin.toString().length == 5
                            ? _full_Otp = true
                            : _full_Otp = false;
                      }

                      setState(() {});
                    }, submit_button_function: () {
                      if (_full_Otp != null && _full_Otp == true) {
                        log("sign in with otp triggered");
                      }
                    })
                  : send_otp(
                      context,
                      function: () {
                        if (_phone_number_entered) _otp_entered = !_otp_entered;
                        setState(() {});
                      },
                      phone_number_controller_function: (String input_number) {
                        input_number.toString().length == 10
                            ? _phone_number_entered = true
                            : _phone_number_entered = false;
                        setState(() {});
                      },
                    ),
              //
              //

              SizedBox(height: 10),
              button_style(
                'Login With Email',
                context,
                function: () {
                  Navigator.pushReplacementNamed(
                      context, app_routes.signin_screen);
                },
              ),
              SizedBox(height: 10),
              forgot_password_button(context),
              SizedBox(height: 10),
              new_user_button(context),
            ],
          ),
        ),
      ),
    );
  }
}
