// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_field, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../designing.dart';
import 'package:foodora/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final storage = new FlutterSecureStorage();

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
                height: height_block * 37,
              ),
              SizedBox(height: 2 * height_block),
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
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 1 * height_block),

              (_isloading == null || _isloading == false)
                  ? SizedBox(
                      height: 3 * height_block,
                      child: _error_reason != null
                          ? error_line(context, _error_reason!)
                          : Text(" "),
                    )
                  : SizedBox(
                      child: CircularProgressIndicator(color: logo_brown_color),
                      height: 3 * height_block,
                      width: 3 * height_block,
                    ),

              SizedBox(height: height_block),
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
                      _error_reason = response['msg'];
                      _checker = true;
                    });

                    if (response['success']) {
                      await storage.write(
                          key: "token",
                          value:
                              JwtDecoder.decode(response['accesstoken'])['id']
                                  .toString());
                      if (response['msg'] == "User Not Verified") {
                        send_api_otp(emailController.text);
                        Navigator.pushReplacementNamed(
                            context, app_routes.otp_verify_screen,
                            arguments: emailController.text);
                      } else
                        Navigator.pushNamed(
                            context, app_routes.location_screen);
                    }
                  }

                  setState(() {});
                },
              ),
              SizedBox(height: 2 * height_block),
              forgot_password_button(context),
              SizedBox(height: 2 * height_block),
              new_user_button(context),
            ],
          ),
        ),
      ),
    );
  }
}
