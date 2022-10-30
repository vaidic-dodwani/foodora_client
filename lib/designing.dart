import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodora/app_routes.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

const background_color = Colors.white;
const logo_brown_color = Color(0xFF61481C);
const font_red_color = Color(0xFFDB0007);
const button_background = Color(0xFFF7BCBD);
BoxDecoration background_design() {
  return const BoxDecoration(
    color: background_color,
  );
}

Widget skip_button(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, app_routes.location_screen);
      },
      child: Text(
        "SKIP",
        style: TextStyle(
            fontFamily: 'Inner',
            fontSize: 2.5 * height_block,
            color: font_red_color,
            fontVariations: <FontVariation>[FontVariation('wght', 700)]),
      ),
    ),
  );
}

Widget sign_button(String text, {fontcolor = Colors.white, double? fontsize}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontsize,
      color: fontcolor,
      fontVariations: <FontVariation>[FontVariation('wght', 700)],
      fontFamily: 'Inter',
    ),
  );
}

SizedBox button_style(
  String text,
  BuildContext context, {
  Color color = button_background,
  function,
  fontcolor = font_red_color,
  double? fontsize,
}) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  fontsize = 3 * height_block;
  return SizedBox(
    height: 6 * height_block,
    width: size.width > size.height ? height_block * 60 : width_block * 80,
    child: TextButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 1, color: font_red_color),
          ),
        ),
      ),
      child: sign_button(text, fontsize: fontsize, fontcolor: fontcolor),
    ),
  );
}

Widget top_welcome_text(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Text(
      text,
      style: const TextStyle(
          color: font_red_color,
          fontSize: 24,
          fontVariations: <FontVariation>[FontVariation('wght', 700)],
          fontFamily: 'Montserrat'),
    ),
  );
}

Widget form_text(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Padding(
    padding: EdgeInsets.only(left: width_block * 2),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: logo_brown_color,
            fontFamily: 'Montserrat',
            fontSize: 3 * height_block,
            fontVariations: <FontVariation>[FontVariation('wght', 500)]),
      ),
    ),
  );
}

Widget form_field(BuildContext context, String text,
    {bool password = false, icon, bool isEmail = false, controller, function}) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Padding(
    padding: EdgeInsets.only(left: 2 * width_block),
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 90 * width_block,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          onChanged: (String input_value) {
            if (function != null) function(input_value);
          },
          obscureText: password,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          autocorrect: !password,
          style: TextStyle(
              fontSize: 2 * height_block,
              fontVariations: <FontVariation>[FontVariation('wght', 500)]),
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            suffixIcon: icon,
            hintText: text,
          ),
        ),
      ),
    ),
  );
}

Widget forgot_password_button(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, app_routes.forgot_password_screen);
    },
    child: Text(
      "Forgot Password",
      style: TextStyle(
          fontSize: 4 * height_block,
          color: font_red_color,
          fontFamily: 'Montserrat',
          fontVariations: <FontVariation>[FontVariation('wght', 500)]),
    ),
  );
}

Widget screen_heading(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        color: font_red_color,
        fontVariations: <FontVariation>[FontVariation('wght', 700)]),
  );
}

Widget screen_center_text(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18,
        fontFamily: 'Montserrat',
        color: font_red_color,
        fontVariations: <FontVariation>[FontVariation('wght', 700)]),
  );
}

Widget new_user_button(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "New to Foodora??",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontVariations: <FontVariation>[FontVariation('wght', 500)],
            fontSize: 3 * height_block),
      ),
      TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, app_routes.signup_screen);
        },
        child: Text(
          "SIGN UP",
          style: TextStyle(
              fontSize: 3 * height_block,
              color: font_red_color,
              fontFamily: 'Montserrat',
              fontVariations: <FontVariation>[FontVariation('wght', 700)]),
        ),
      )
    ],
  );
}

Widget existing_user_button(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Already Registered?",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontVariations: <FontVariation>[FontVariation('wght', 500)],
            fontSize: 24),
      ),
      TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, app_routes.signin_screen);
        },
        child: Text(
          "SIGN IN",
          style: TextStyle(
              fontSize: 24,
              color: font_red_color,
              fontFamily: 'Montserrat',
              fontVariations: <FontVariation>[FontVariation('wght', 700)]),
        ),
      )
    ],
  );
}

Widget phone_number_field(BuildContext context, {function, controller}) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
    height: 50,
    width: size.width > 330 ? 330 : size.width - 10,
    child: TextField(
      controller: controller,
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      onChanged: (String input_number) {
        if (function == null)
          function() {}
        else
          function(input_number);
      },
      decoration: InputDecoration(
        counterText: "",
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: 'Enter Email Address',
        hintMaxLines: 1,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget otp_field(BuildContext context, {function}) {
  final size = MediaQuery.of(context).size;
  return OTPTextField(
    keyboardType: TextInputType.text,
    length: 6,
    width: size.width > 330 ? 330 : size.width - 10,
    fieldWidth: size.width > 330 ? 330 / 7 : (size.width - 10) / 7,
    style: TextStyle(fontSize: 20),
    textFieldAlignment: MainAxisAlignment.spaceAround,
    fieldStyle: FieldStyle.box,
    onChanged: (pin) {
      function(pin);
    },
  );
}

Widget email_otp_verify(BuildContext context, bool? full_otp,
    {otp_controller_function,
    error_line = " ",
    int sent = 0,
    resend_function}) {
  final size = MediaQuery.of(context).size;
  return Column(
    children: [
      otp_field(context, function: otp_controller_function),
      SizedBox(
        width: size.width > 330 ? 330 : size.width - 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sent == 0
                ? TextButton(
                    onPressed: resend_function,
                    child: resend(function: resend_function))
                : const Text(
                    "Resent the OTP",
                    style: TextStyle(color: logo_brown_color),
                  ),
            Text(
              error_line,
              style: TextStyle(fontSize: 16, color: Colors.red),
            )
          ],
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}

Widget resend({function}) {
  return TextButton(
    onPressed: function,
    child: const Text(
      "Resend",
      style: TextStyle(
          fontSize: 15,
          fontVariations: <FontVariation>[FontVariation('wght', 400)],
          color: logo_brown_color),
    ),
  );
}

Widget error_line(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  return SizedBox(
    height: 3 * height_block,
    child: Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 2 * width_block),
        child: Text(
          text,
          style: TextStyle(fontSize: 2 * height_block, color: font_red_color),
        ),
      ),
    ),
  );
}

Column send_otp(BuildContext context,
    {function, phone_number_controller_function}) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Column(children: [
    SizedBox(height: 30),
    phone_number_field(context, function: phone_number_controller_function),
    SizedBox(height: 10),
    button_style('SEND OTP', context, function: function),
    const SizedBox(height: 10),
  ]);
}

Column otp_input(BuildContext context, bool? full_otp,
    {otp_controller_function, submit_button_function}) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Column(
    children: [
      SizedBox(
        width: size.width > 330 ? 330 : size.width - 10,
        child: const Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            "Please Enter The OTP",
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'Montserrat',
              color: logo_brown_color,
              fontVariations: <FontVariation>[FontVariation('wght', 500)],
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      otp_field(context, function: otp_controller_function),
      SizedBox(
        width: size.width > 330 ? 330 : size.width - 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                "Resend",
                style: TextStyle(fontSize: 15),
              ),
            ),
            (full_otp == null || full_otp)
                ? SizedBox(width: 50)
                : const Text(
                    "Enter The Entire OTP",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  )
          ],
        ),
      ),
      button_style("Submit", context, function: submit_button_function),
      SizedBox(height: 10),
    ],
  );
}

bool isEmail(String email) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email))
    return true;
  else
    return false;
}

bool isStrong(String? password) {
  if (password == null) {
    return false;
  } else if (RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password)) {
    return true;
  } else {
    return false;
  }
}
