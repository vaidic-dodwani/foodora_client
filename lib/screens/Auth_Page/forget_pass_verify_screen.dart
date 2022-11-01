import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/screens/Location_Page/Location_Screen.dart';
import 'package:http/http.dart';

import '../../config/api_integration.dart';

class forget_pass_verify_screen extends StatefulWidget {
  final String email;
  const forget_pass_verify_screen({super.key, required this.email});

  @override
  State<forget_pass_verify_screen> createState() =>
      _forget_pass_verify_screenState();
}

class _forget_pass_verify_screenState extends State<forget_pass_verify_screen> {
  TextEditingController passwordController = TextEditingController();
  dynamic _input_pin;
  PasswordChecker pass = new PasswordChecker(null, null);
  int _sent = 0;
  bool? reset_error;
  bool _isLoading = false;
  bool _checker = false;
  bool? _full_Otp;
  bool _otp_verified = false;
  bool _show_password = false;
  bool _show_retype_password = false;
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
              SizedBox(height: 8 * height_block),
              SvgPicture.asset("assets/images/mail_vector.svg"),
              SizedBox(height: 2 * height_block),
              SizedBox(
                width: size.width > 330 ? 330 : size.width - 10,
                child: Column(children: [
                  screen_heading("Enter OTP"),
                  SizedBox(height: 1 * height_block),
                  _otp_verified
                      ? screen_center_text("Please enter new password")
                      : screen_center_text(
                          "Please Enter OTP Sent At Your Email"),
                  SizedBox(height: 3 * height_block),
                  _otp_verified
                      ? Column(
                          children: [
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
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ), function: (input_password) {
                              _password = input_password;
                              pass =
                                  new PasswordChecker(_password, _re_password);
                              _error_line = pass.error;
                              _checker = false;
                              setState(() {});
                            }),
                            SizedBox(height: 22),
                            form_text(context, 'Retype Password'),
                            form_field(
                                context, 'Please retype the same password',
                                password: !_show_retype_password,
                                icon: IconButton(
                                  color: logo_brown_color,
                                  onPressed: () {
                                    _show_retype_password =
                                        !_show_retype_password;
                                    setState(() {});
                                  },
                                  icon: _show_retype_password
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ), function: (input_password) {
                              _re_password = input_password;
                              _checker = false;
                              pass =
                                  new PasswordChecker(_password, _re_password);
                              _error_line = pass.error;
                              setState(() {});
                            }),
                            SizedBox(height: 2 * height_block),
                            _isLoading
                                ? SizedBox(
                                    height: 6 * width_block,
                                    width: 6 * width_block,
                                    child: CircularProgressIndicator(
                                        color: logo_brown_color),
                                  )
                                : (pass.ifError &&
                                        !_checker &&
                                        (reset_error == false ||
                                            reset_error == null))
                                    ? Text(" ")
                                    : error_line(context, _error_line),
                          ],
                        )
                      : email_otp_verify(
                          context,
                          _full_Otp,
                          resend_function: () {
                            if (_sent < 1) {
                              forget_otp_send(widget.email);
                            }
                            setState(() {
                              _sent = 1;
                            });
                          },
                          sent: _sent,
                          error_line: _error_line,
                          otp_controller_function: (pin) {
                            _input_pin = pin;

                            if (pin.toString().isEmpty) {
                              _full_Otp = null;
                            } else {
                              if (pin.toString().length == 6) {
                                _full_Otp = true;
                                setState(() {
                                  _error_line = " ";
                                });
                              } else {
                                _full_Otp = false;
                                setState(() {
                                  _error_line = "Please Enter Entire OTP";
                                });
                              }
                            }

                            setState(() {});
                          },
                        ),
                  SizedBox(height: 2 * height_block),
                  button_style("RESET PASSWORD", context, function: () async {
                    if (!_otp_verified) {
                      if (_full_Otp != null && _full_Otp == true) {
                        setState(() {
                          _isLoading = true;
                        });
                        final response =
                            await forget_otp_verify(widget.email, _input_pin);
                        setState(() {
                          _isLoading = false;
                        });

                        if (response['success']) {
                          setState(() {
                            _otp_verified = true;
                          });
                        }
                      }
                    } else {
                      if (pass.ifError) {
                        setState(() {
                          _isLoading = true;
                        });
                        final response =
                            await forget_new_password(widget.email, _password);
                        setState(() {
                          _isLoading = false;
                        });
                        if (response['success']) {
                          Navigator.pushReplacementNamed(
                              context, app_routes.location_screen);
                        }
                        setState(() {
                          _error_line = response['msg'];
                          reset_error = true;
                          log(_error_line);
                        });
                      }
                    }
                  }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
