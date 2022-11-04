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
  PasswordChecker pass = new PasswordChecker(null, null);
  bool? _emptyName;
  String _error_line = " ";

  dynamic _password, _re_password;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          decoration: background_design(),
          child: Column(
            children: [
              SizedBox(height: 2 * height_block),
              skip_button(context),
              SizedBox(height: height_block),
              top_welcome_text(context, "Welcome to FOODORA"),
              SizedBox(
                height: 7.5 * height_block,
              ),
              form_text(context, 'FULL NAME'),
              form_field(
                context,
                'Your Name',
                controller: nameController,
                function: (text) {
                  text.length == 0 ? _emptyName = true : _emptyName = false;
                  setState(() {});
                },
              ),
              (_emptyName == null || _emptyName == false)
                  ? SizedBox(height: 3 * height_block)
                  : error_line(context, "Enter Name"),
              form_text(context, 'Email Address'),
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
                  ? SizedBox(height: 3 * height_block)
                  : error_line(context, "Enter Valid Email"),
              form_text(context, 'Password'),
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
                pass = new PasswordChecker(_password, _re_password);
                _error_line = pass.error;
                _checker = false;
                setState(() {});
              }),
              SizedBox(height: 3 * height_block),
              form_text(context, 'Retype Password'),
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
                pass = new PasswordChecker(_password, _re_password);
                _error_line = pass.error;
                _checker = false;
                setState(() {});
              }),
              SizedBox(height: height_block),
              (_isLoading == null || _isLoading == false)
                  ? SizedBox(
                      height: 3 * height_block,
                      child: (pass.ifError && !_checker)
                          ? Text(" ")
                          : error_line(context, _error_line),
                    )
                  : SizedBox(
                      height: 3 * height_block,
                      width: 3 * height_block,
                      child: CircularProgressIndicator(color: logo_brown_color),
                    ),
              SizedBox(height: height_block),
              button_style('SIGN UP', context, function: () async {
                if (_emptyName == null) {
                  setState(() {
                    _emptyName = true;
                  });
                }
                if ((_emptyName != true || _emptyName == false) &&
                    (_isEmail != null && _isEmail == true) &&
                    pass.ifError) {
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
                    Navigator.pushReplacementNamed(
                        context, app_routes.otp_verify_screen,
                        arguments: emailController.text);
                  } else {
                    _error_line = response['msg'];
                  }
                }
                setState(() {});
              }),
              SizedBox(height: 3 * height_block),
              existing_user_button(context),
            ],
          ),
        ),
      ),
    );
  }
}
