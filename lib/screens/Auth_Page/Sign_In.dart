import 'package:flutter/material.dart';

import '../../designing.dart';

class signin_screen extends StatefulWidget {
  const signin_screen({super.key});

  @override
  State<signin_screen> createState() => _signin_screenState();
}

class _signin_screenState extends State<signin_screen> {
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
            skip_button(),
            SizedBox(height: 10),
            welcome_back(),
            SizedBox(
              height: size.height * 0.3,
            ),
            form_text('Email'),
            form_field(context, 'example@email.com'),
            SizedBox(height: 10),
            form_text('Password'),
            form_field(
              context,
              'Password',
              password: true,
              icon: Icon(Icons.visibility),
            ),
            SizedBox(height: 30),
            button_style("Sign In", context),
            SizedBox(height: 10),
            button_style("OTP Login", context, color: Color(0xFFFB882C)),
            SizedBox(height: 10),
            button_style("New User", context, color: Color(0xFF813531)),
          ],
        ),
      ),
    ));
  }
}
