import 'package:flutter/material.dart';
import '../../designing.dart';
import 'package:foodora/app_routes.dart';

class signin_screen extends StatefulWidget {
  const signin_screen({super.key});

  @override
  State<signin_screen> createState() => _signin_screenState();
}

class _signin_screenState extends State<signin_screen> {
  TextEditingController emailController = TextEditingController();
  bool _show_password = false;
  bool _checker = false;
  bool _isEmail = false;

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
              //
              skip_button(context),
              //
              SizedBox(height: 10),
              top_welcome_text('Welcome Back!'),
              //
              SizedBox(
                height: size.height * 0.3,
              ),
              form_text('Email'),
              //
              form_field(
                context,
                'example@email.com',
                isEmail: true,
                controller: emailController,
                function: (String input_text) {
                  isEmail(input_text) ? _isEmail = true : _isEmail = false;
                  setState(() {});
                },
              ),
              _isEmail ? SizedBox(height: 21) : error_line("Invalid Email"),
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
              _checker
                  ? error_line("Invalid Password")
                  : SizedBox(
                      height: 21,
                    ),
              SizedBox(height: 10),
              button_style(
                "Sign In",
                context,
                function: () {
                  if (_isEmail) _checker = true;
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              button_style("OTP Login", context, color: orange_button_color,
                  function: () {
                Navigator.pushNamed(context, app_routes.otp_screen);
              }),
              SizedBox(height: 10),
              button_style(
                "New User",
                context,
                color: new_user_color,
                function: () {
                  Navigator.pushNamed(context, app_routes.signup_screen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
