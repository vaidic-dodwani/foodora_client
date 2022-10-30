import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/config/api_integration.dart';
import '../../designing.dart';
import 'package:foodora/app_routes.dart';

class signin_screen extends StatefulWidget {
  const signin_screen({super.key});

  @override
  State<signin_screen> createState() => _signin_screenState();
}

class _signin_screenState extends State<signin_screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _error_reason;
  bool _show_password = false;
  bool _checker = false;
  bool? _isloading;
  bool? _isEmail;

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
              //
              skip_button(context),
              //

              //
              SvgPicture.asset(
                "assets/images/sign_in_vector.svg",
                height: height_block * 40,
              ),

              form_text(context, 'Email'),
              //
              form_field(
                context,
                'example@email.com',
                isEmail: true,
                controller: emailController,
                function: (String input_text) {
                  if (input_text.isEmpty)
                    _isEmail = null;
                  else {
                    isEmail(input_text) ? _isEmail = true : _isEmail = false;
                  }
                  setState(() {});
                },
              ),
              _isEmail == true || _isEmail == null
                  ? SizedBox(height: 22)
                  : error_line(context, "Invalid Email"),

              form_text(context, 'Password'),
              form_field(
                context,
                'Password',
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
                ),
              ),

              (_isloading == null || _isloading == false)
                  ? SizedBox(
                      height: 21,
                      child: _error_reason != null
                          ? error_line(context, _error_reason!)
                          : Text(" "),
                    )
                  : const SizedBox(
                      child: CircularProgressIndicator(color: logo_brown_color),
                      height: 21,
                      width: 21,
                    ),

              SizedBox(height: 2 * height_block),
              button_style(
                "Sign In",
                context,
                function: () async {
                  if (_isEmail == true) {
                    setState(() {
                      _isloading = true;
                    });
                    final response = await sign_in(
                        emailController.text, passwordController.text);
                    setState(() {
                      _isloading = false;
                    });
                    _error_reason = response['msg'];
                    _checker = true;
                    if (response['success']) {
                      Navigator.pushNamed(context, app_routes.location_screen);
                    }
                    if (response['msg'] == "User Not Verified") {
                      send_api_otp(emailController.text);
                      Navigator.pushReplacementNamed(
                          context, app_routes.otp_verify_screen,
                          arguments: emailController.text);
                    }
                  }

                  setState(() {});
                },
              ),
              SizedBox(height: 20),
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
