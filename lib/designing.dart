import 'dart:developer';

import 'package:flutter/material.dart';

const background_top = Color(0xFFE3C766);
const background_bottom = Color(0xFFFFCC00);
const logo_brown_color = Color(0xFF61481C);
const font_brown_color = Color(0xFF61481C);
const button_background = Color(0xFF61481C);

BoxDecoration background_design() {
  return const BoxDecoration(
    gradient: LinearGradient(
        colors: [background_top, background_bottom],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  );
}

Widget skip_button({function}) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: function,
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
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Welcome Back!',
        style: TextStyle(
            fontSize: 24, color: font_brown_color, fontWeight: FontWeight.w700),
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
    {bool password = false, icon}) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: size.width * 0.9,
        child: TextFormField(
          obscureText: password,
          style: const TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            suffixIcon: icon,
            hintText: text,
          ),
        ),
      ),
    ),
  );
}

