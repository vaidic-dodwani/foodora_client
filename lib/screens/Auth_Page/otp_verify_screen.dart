import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/error.dart';

class otp_verify_screen extends StatefulWidget {
  const otp_verify_screen({super.key});

  @override
  State<otp_verify_screen> createState() => _otp_verify_screenState();
}

class _otp_verify_screenState extends State<otp_verify_screen> {
  TextEditingController passwordController = TextEditingController();
  bool _checker = false;
  bool? _full_Otp;
  bool _otp_verified = false;
  bool _show_password = false;
  bool _show_retype_password = false;
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
              SizedBox(height: 15),
              skip_button(context),
              SizedBox(height: 10),
              SvgPicture.asset("assets/images/mail_vector.svg"),
              SizedBox(height: 15),
              SizedBox(
                width: size.width > 330 ? 330 : size.width - 10,
                child: Column(children: [
                  screen_heading("Enter OTP"),
                  SizedBox(height: 10),
                  _otp_verified
                      ? screen_center_text("Please enter new password")
                      : screen_center_text(
                          "Please Enter OTP Sent At Your Email"),
                  SizedBox(height: 25),
                  _otp_verified
                      ? Column(
                          children: [
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
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ), function: (input_password) {
                              _re_password = input_password;
                              _checker = false;
                              _error_line = "Passwords Do Not Match";
                              setState(() {});
                            }),
                            (_password == _re_password && !_checker)
                                ? Text(" ")
                                : error_line(_error_line),
                          ],
                        )
                      : email_otp_verify(
                          context,
                          _full_Otp,
                          otp_controller_function: (pin) {
                            if (pin.toString().isEmpty) {
                              _full_Otp = null;
                            } else {
                              pin.toString().length == 5
                                  ? _full_Otp = true
                                  : _full_Otp = false;
                            }

                            setState(() {});
                          },
                        ),
                  SizedBox(height: 30),
                  button_style("RESET PASSWORD", context, function: () {
                    if (_full_Otp != null && _full_Otp == true) {
                      setState(() {
                        _otp_verified = true;
                      });
                    }
                    ;
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
