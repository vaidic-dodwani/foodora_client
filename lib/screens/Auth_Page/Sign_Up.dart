import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/app_routes.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  bool _show_password = false;
  bool _show_retype_password = false;
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
              SizedBox(height: 10),
              const Text(
                "WELCOME TO FOODORA",
                style: TextStyle(
                  fontSize: 24,
                  color: font_brown_color,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              form_text('FULL NAME'),
              form_field(context, 'Your Name'),
              SizedBox(height: 10),
              form_text('Email Address'),
              form_field(context, 'example@email.com', isEmail: true),
              SizedBox(height: 10),
              form_text('Password'),
              form_field(
                context,
                'Password',
                password: !_show_password,
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
              form_text('Retype Password'),
              form_field(
                context,
                'Password',
                password: !_show_retype_password,
                icon: IconButton(
                  onPressed: () {
                    _show_retype_password = !_show_retype_password;
                    setState(() {});
                  },
                  icon: _show_retype_password
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              button_style('SignUP', context),
              SizedBox(height: 10),
              button_style(
                'Existing User',
                context,
                color: Color(0xFF813531),
                function: () {
                  Navigator.pushNamed(context, app_routes.signin_screen);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
