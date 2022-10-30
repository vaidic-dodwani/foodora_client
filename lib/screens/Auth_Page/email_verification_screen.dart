import 'package:foodora/app_routes.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/screens/Auth_Page/otp_verify_screen.dart';

class email_verification_screen extends StatefulWidget {
  const email_verification_screen({super.key});

  @override
  State<email_verification_screen> createState() =>
      _email_verification_screenState();
}

class _email_verification_screenState extends State<email_verification_screen> {
  TextEditingController emailController = TextEditingController();
  bool? _isEmail;
  bool? _isloading;
  String? _error_text;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: background_design(),
          width: size.width,
          child: Column(children: [
            SizedBox(height: 100),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: top_welcome_text("CONTACT DETAIL"),
              ),
            ),
            SizedBox(height: 10),
            SvgPicture.asset("assets/images/email_verification.svg"),
            SizedBox(height: 30),
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
                            error_line(context, _error_text!),
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
                      context, app_routes.otp_verify_screen,
                      arguments: emailController.text);
                } else {
                  setState(() {
                    _error_text = response['msg'];
                  });
                }
              }
            }),
            SizedBox(height: 20),
            existing_user_button(context),
          ]),
        ),
      ),
    );
  }
}
