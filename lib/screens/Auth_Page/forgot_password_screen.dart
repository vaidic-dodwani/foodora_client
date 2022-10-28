import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/designing.dart';
import '../../config/api_integration.dart';

class forgot_password_screen extends StatefulWidget {
  const forgot_password_screen({super.key});

  @override
  State<forgot_password_screen> createState() => _forgot_password_screenState();
}

class _forgot_password_screenState extends State<forgot_password_screen> {
  TextEditingController emailController = TextEditingController();
  bool? _isEmail;
  bool? _isloading;
  String? _error_text;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: background_design(),
          width: size.width,
          child: Column(children: [
            SizedBox(height: 30),
            skip_button(context),
            SizedBox(height: 10),
            SvgPicture.asset("assets/images/forget_password_vector.svg"),
            SizedBox(height: 10),
            screen_heading("Forgot Password"),
            SizedBox(height: 10),
            screen_center_text("Please enter your Email to verify"),
            SizedBox(height: 50),
            phone_number_field(context, controller: emailController,
                function: (input_text) {
              if (input_text.toString().length == 0) {
                _isEmail = null;
              } else {
                if (isEmail(input_text)) {
                  _isEmail = true;
                  _error_text = null;
                } else {
                  _isEmail = false;
                  _error_text = "Invalid Email";
                }
              }
              setState(() {});
            }),
            SizedBox(height: 11),
            (_isloading == null || _isloading == false)
                ? (_error_text == null)
                    ? SizedBox(height: 33)
                    : Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          children: [
                            error_line(_error_text!),
                            SizedBox(height: 11)
                          ],
                        ),
                      )
                : const SizedBox(
                    child: CircularProgressIndicator(color: logo_brown_color),
                    height: 33,
                    width: 33,
                  ),
            SizedBox(height: 11),
            button_style("SEND OTP", context, function: () async {
              if (_isEmail == true) {
                setState(() {
                  _isloading = true;
                });
                final response = await send_api_otp(emailController.text);
                setState(() {
                  _isloading = false;
                });
                if (response['success']) {
                  Navigator.pushReplacementNamed(
                      context, app_routes.forget_pass_verify_screen);
                } else {
                  setState(() {
                    _error_text = response['msg'];
                  });
                }
              }
            }),
            SizedBox(height: 20),
            new_user_button(context),
          ]),
        ),
      ),
    );
  }
}
