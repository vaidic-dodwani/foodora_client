import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/config/api_integration.dart';

import '../../designing.dart';

class otp_verify_screen extends StatefulWidget {
  final String email;
  const otp_verify_screen({super.key, required this.email});

  @override
  State<otp_verify_screen> createState() => _otp_verify_screenState();
}

class _otp_verify_screenState extends State<otp_verify_screen> {
  int _sent = 0;
  bool _isloading = false;
  late String _pin;
  bool _checker = false;
  bool? _full_Otp;
  bool _otp_verified = false;
  String _error_line = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: background_design(),
          child: Column(
            children: [
              SizedBox(height: 100),
              screen_heading("Verify your Email"),
              SizedBox(height: 10),
              SvgPicture.asset("assets/images/email_verify_vector.svg"),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: screen_center_text(
                    "Please Enter OTP Sent At " + widget.email),
              ),
              SizedBox(height: 20),
              email_otp_verify(
                context,
                _full_Otp,
                resend_function: () {
                  if (_sent < 1) {
                    send_api_otp(widget.email);
                  }

                  setState(() {
                    _sent = 1;
                  });
                },
                sent: _sent,
                error_line: _error_line,
                otp_controller_function: (pin) {
                  _pin = pin.toString();
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
              _isloading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: font_red_color,
                      ),
                    )
                  : SizedBox(height: 20),
              SizedBox(height: 20),
              button_style("Sign UP", context, function: () async {
                log(_sent.toString());
                if (_full_Otp != null && _full_Otp == true) {
                  setState(() {
                    _isloading = true;
                  });
                  final response = await otp_correct(widget.email, _pin);
                  setState(() {
                    _isloading = false;
                    _otp_verified = true;
                  });
                  if (response['success']) {
                    Navigator.pushReplacementNamed(
                        context, app_routes.location_screen);
                  } else {
                    setState(() {
                      _error_line = response['msg'];
                    });
                  }
                }
                ;
              }),
              SizedBox(height: 20),
              new_user_button(context)
            ],
          ),
        ),
      ),
    );
  }
}
