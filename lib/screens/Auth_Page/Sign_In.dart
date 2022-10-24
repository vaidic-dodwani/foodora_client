import 'dart:developer';

import 'package:flutter/material.dart';
import '../../designing.dart';
import 'package:foodora/app_routes.dart';

class signin_screen extends StatefulWidget {
  const signin_screen({super.key});

  @override
  State<signin_screen> createState() => _signin_screenState();
}

class _signin_screenState extends State<signin_screen> {
  bool _show_password = false;
  bool _checker = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: background_design(),
        child: Column(
          children: [
            SizedBox(height: 10),
            skip_button(context),
            SizedBox(height: 10),
            welcome_back(),
            SizedBox(
              height: size.height * 0.3,
            ),
            form_text('Email'),
            form_field(context, 'example@email.com', isEmail: true),
            SizedBox(height: 10),
            form_text('Password'),
            form_field(
              context,
              'Password',
              password: _show_password,
              icon: IconButton(
                onPressed: () {
                  _show_password = !_show_password;
                  setState(() {});
                },
                icon: _show_password
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 10),
            if (_checker) validation(),
            SizedBox(height: 10),
            button_style(
              "Sign In",
              context,
              function: () {
                _checker = true;
                setState(() {});
              },
            ),
            SizedBox(height: 10),
            button_style("OTP Login", context, color: Color(0xFFFB882C),
                function: () {
              Navigator.pushNamed(context, app_routes.otp_screen);
            }),
            SizedBox(height: 10),
            button_style(
              "New User",
              context,
              color: Color(0xFF813531),
              function: () {
                Navigator.pushNamed(context, app_routes.signup_screen);
              },
            ),
          ],
        ),
      ),
    ));
  }
}

validation() {
  if (true) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          'Invalid Password',
          style: TextStyle(fontSize: 16, color: font_red_color),
        ),
      ),
    );
  } else
    return SizedBox(height: 22);
}
