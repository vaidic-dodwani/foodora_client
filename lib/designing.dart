import 'package:flutter/material.dart';
import 'package:foodora/app_routes.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

const background_top = Color(0xFFE3C766);
const background_bottom = Color(0xFFFFCC00);
const logo_brown_color = Color(0xFF61481C);
const font_brown_color = Color(0xFF61481C);
const font_red_color = Color(0xFFE30303);
const button_background = Color(0xFF61481C);
const orange_button_color = Color(0xFFFB882C);
const new_user_color = Color(0xFF813531);
BoxDecoration background_design() {
  return const BoxDecoration(
    gradient: LinearGradient(
        colors: [background_top, background_bottom],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  );
}

Widget skip_button(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, app_routes.home_screen);
      },
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          "SKIP",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              color: font_brown_color,
              fontWeight: FontWeight.w700),
        ),
      ),
    ),
  );
}

Widget sign_button(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Inter',
    ),
  );
}

SizedBox button_style(String text, BuildContext context,
    {Color color = button_background, function}) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
    height: 50,
    width: size.width > 330 ? 330 : size.width - 10,
    child: TextButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 1),
          ),
        ),
      ),
      child: sign_button(text),
    ),
  );
}

Widget welcome_back() {
  return const Padding(
    padding: EdgeInsets.only(left: 10.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Welcome Back!',
        style: TextStyle(
            fontSize: 24,
            color: font_brown_color,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat'),
      ),
    ),
  );
}

Widget form_text(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget form_field(BuildContext context, String text,
    {bool password = false, icon, bool isEmail = false}) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: size.width * 0.9,
        child: TextFormField(
          obscureText: password,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          autocorrect: !password,
          style: const TextStyle(
            fontSize: 16,
          ),
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
            suffixIconColor: Colors.black,
            suffixIcon: icon,
            hintText: text,
          ),
        ),
      ),
    ),
  );
}

Widget phone_number_field(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
    height: 50,
    width: size.width > 330 ? 330 : size.width - 10,
    child: TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: 'Enter Mobile Number',
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget otp_field(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return OTPTextField(
    length: 5,
    width: size.width > 330 ? 330 : size.width - 10,
    fieldWidth: size.width > 330 ? 330 / 6 : (size.width - 10) / 6,
    style: TextStyle(fontSize: 20),
    textFieldAlignment: MainAxisAlignment.spaceAround,
    fieldStyle: FieldStyle.box,
    onCompleted: (pin) {},
  );
}

Column send_otp(BuildContext context, {function}) {
  return Column(children: [
    SizedBox(height: 30),
    phone_number_field(context),
    SizedBox(height: 10),
    button_style('SEND OTP', context, function: function),
    const SizedBox(height: 10),
  ]);
}

Column otp_input(BuildContext context) {
  final size = MediaQuery.of(context).size;
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
              color: font_brown_color,
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      otp_field(context),
      SizedBox(
        width: size.width > 330 ? 330 : size.width - 10,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Resend",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
      button_style("Submit", context),
      SizedBox(height: 10),
    ],
  );
}
