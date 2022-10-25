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
  bool _isEmail = false;
  bool _checker = false;
  bool _samePassword = false;
  bool _emptyName = true;
  dynamic _password, _re_password;
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
              form_field(
                context,
                'Your Name',
                function: (text) {
                  text.length == 0 ? _emptyName = true : _emptyName = false;
                  setState(() {});
                },
              ),
              _emptyName ? error_line("Enter Name") : SizedBox(width: 21),
              SizedBox(height: 10),
              form_text('Email Address'),
              form_field(context, 'example@email.com', isEmail: true,
                  function: (input_text) {
                isEmail(input_text) ? _isEmail = true : _isEmail = false;
                setState(() {});
              }),
              _isEmail ? SizedBox(height: 21) : error_line("Enter Valid Email"),
              form_text('Password'),
              form_field(context, 'Password',
                  password: !_show_password,
                  icon: IconButton(
                    onPressed: () {
                      _show_password = !_show_password;
                      setState(() {});
                    },
                    icon: _show_password
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ), function: (input_password) {
                _password = input_password;
                setState(() {});
              }),
              SizedBox(height: 10),
              form_text('Retype Password'),
              form_field(context, 'Please retype the same password',
                  password: !_show_retype_password,
                  icon: IconButton(
                    onPressed: () {
                      _show_retype_password = !_show_retype_password;
                      setState(() {});
                    },
                    icon: _show_retype_password
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ), function: (input_password) {
                _re_password = input_password;
                setState(() {});
              }),
              SizedBox(height: 10),
              (_password == _re_password)
                  ? SizedBox(height: 21)
                  : error_line("Passwords Do Not Match"),
              SizedBox(height: 10),
              _checker
                  ? error_line("Invalid Password")
                  : SizedBox(
                      height: 21,
                    ),
              SizedBox(height: 10),
              button_style('Sign Up', context, function: () {
                if (!_emptyName && _isEmail && _password == _re_password) {
                  _checker = true;
                  setState(() {});
                }
              }),
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
