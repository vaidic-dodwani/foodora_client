import 'package:flutter/material.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/app_routes.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _show_password = false;
  bool _show_retype_password = false;
  bool? _isEmail;
  bool? _isLoading;
  bool _checker = false;
  bool _samePassword = false;
  bool? _emptyName;
  String _error_line = "Passwords Do Not Match";

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
                controller: nameController,
                function: (text) {
                  text.length == 0 ? _emptyName = null : _emptyName = false;
                  setState(() {});
                },
              ),
              (_emptyName == null || _emptyName == true)
                  ? error_line("Enter Name")
                  : SizedBox(width: 22),
              form_text('Email Address'),
              form_field(context, 'example@email.com',
                  isEmail: true,
                  controller: emailController, function: (input_text) {
                if (input_text.toString().length == 0) {
                  _isEmail = null;
                } else {
                  isEmail(input_text) ? _isEmail = true : _isEmail = false;
                }
                setState(() {});
              }),
              (_isEmail == null || _isEmail == true)
                  ? SizedBox(height: 22)
                  : error_line("Enter Valid Email"),
              form_text('Password'),
              form_field(context, 'Password',
                  password: !_show_password,
                  controller: passwordController,
                  icon: IconButton(
                    color: logo_brown_color,
                    onPressed: () {
                      _show_password = !_show_password;
                      setState(() {});
                    },
                    icon: _show_password
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ), function: (input_password) {
                _password = input_password;
                _error_line = "Passwords Do Not Match";
                _checker = false;
                setState(() {});
              }),
              SizedBox(height: 22),
              form_text('Retype Password'),
              form_field(context, 'Please retype the same password',
                  password: !_show_retype_password,
                  icon: IconButton(
                    color: logo_brown_color,
                    onPressed: () {
                      _show_retype_password = !_show_retype_password;
                      setState(() {});
                    },
                    icon: _show_retype_password
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ), function: (input_password) {
                _re_password = input_password;
                _checker = false;
                _error_line = "Passwords Do Not Match";
                setState(() {});
              }),
              SizedBox(height: 10),
              (_isLoading == null || _isLoading == false)
                  ? SizedBox(
                      height: 22,
                      child: (_password == _re_password && !_checker)
                          ? Text(" ")
                          : error_line(_error_line),
                    )
                  : const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(color: font_brown_color),
                    ),
              SizedBox(height: 10),
              button_style('Sign Up', context, function: () async {
                if ((_emptyName != null || _emptyName == false) &&
                    (_isEmail != null && _isEmail == true) &&
                    _password == _re_password) {
                  _checker = true;
                  setState(() {
                    _isLoading = true;
                  });
                  dynamic response = await sign_up(nameController.text,
                      emailController.text, passwordController.text);
                  setState(() {
                    _isLoading = false;
                  });

                  if (response['success']) {
                    Navigator.pushNamed(context, app_routes.location_screen);
                  } else {
                    _error_line = response['msg'];
                  }
                }
                setState(() {});
              }),
              SizedBox(height: 10),
              button_style(
                'Existing User',
                context,
                color: new_user_color,
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
