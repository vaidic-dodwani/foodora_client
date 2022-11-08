import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodora/app_routes.dart';
import 'package:marquee_vertical/marquee_vertical.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

const background_color = Color(0xFF2B1E29);
const font_color = Color(0xFF2B1E29);
const logo_brown_color = Color(0xFF61481C);
const font_red_color = Color(0xFFDB0007);
const font_yellow_color = Color(0xFFFFBC0D);
const font_green_color = Color(0xFF97ED01);
const button_background = Color(0xFFFDF401);
const home_background_color = Color(0xFF2B1E29);
const card_background_color = Color(0xFFE4EFCD);
const rating_background_color = Color(0xFF378F00);
const nav_bar_color = Color(0xFF3E2C3B);
BoxDecoration background_design() {
  return const BoxDecoration(
    color: background_color,
  );
}

// ignore: non_constant_identifier_names
Widget skip_button(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  final storage = new FlutterSecureStorage();
  final guest_user_info = {
    "success": true,
    "msg": "Guess User",
    "username": "Guest User",
    "emailid": "Guest User"
  };

  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('user_info', jsonEncode(guest_user_info));

        await storage.write(key: 'token', value: 'GUEST USER');

        Navigator.pushNamed(context, app_routes.location_screen);
      },
      child: Text(
        "SKIP",
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 4 * width_block,
            color: Colors.white,
            fontVariations: <FontVariation>[FontVariation('wght', 400)]),
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
  fontsize = 7 * width_block;
  return SizedBox(
    height: 13 * width_block,
    width: size.width > size.height ? height_block * 60 : width_block * 80,
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
      child: sign_button(text, fontsize: fontsize, fontcolor: fontcolor),
    ),
  );
}

Widget top_welcome_text(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Padding(
    padding: EdgeInsets.only(left: width_block * 2),
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white,
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
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 7 * width_block,
            fontVariations: <FontVariation>[FontVariation('wght', 500)]),
      ),
    ),
  );
}

Widget form_field(BuildContext context, String text,
    {bool password = false,
    icon,
    bool isEmail = false,
    controller,
    function,
    maxlen}) {
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
          maxLength: maxlen,
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
              fontSize: 5 * width_block,
              color: Colors.white,
              fontVariations: <FontVariation>[FontVariation('wght', 500)]),
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              suffixIcon: icon,
              hintText: text,
              hintStyle: const TextStyle(
                color: Colors.white70,
              )),
        ),
      ),
    ),
  );
}

Widget phone_form_field(BuildContext context, String text,
    {controller, function, maxlen}) {
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
          maxLength: maxlen,
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          onChanged: (String input_value) {
            if (function != null) function(input_value);
          },
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 5 * width_block,
              color: Colors.white,
              fontVariations: <FontVariation>[FontVariation('wght', 500)]),
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              suffixIcon: Icon(
                Icons.edit_sharp,
                color: Colors.white,
              ),
              hintText: text,
              hintStyle: const TextStyle(
                color: Colors.white70,
              )),
        ),
      ),
    ),
  );
}

Widget forgot_password_button(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(right: width_block * 5),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, app_routes.forgot_password_screen);
        },
        child: Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: 4 * width_block,
              color: font_yellow_color,
              fontFamily: 'Montserrat',
              fontVariations: <FontVariation>[FontVariation('wght', 600)]),
        ),
      ),
    ),
  );
}

Widget screen_heading(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontVariations: <FontVariation>[FontVariation('wght', 700)]),
  );
}

Widget screen_center_text(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 18,
        fontFamily: 'Montserrat',
        color: Colors.white,
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
        "Don’t have an account?",
        style: TextStyle(
            color: Colors.white70,
            fontFamily: 'Montserrat',
            fontVariations: <FontVariation>[FontVariation('wght', 500)],
            fontSize: 3 * width_block),
      ),
      TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, app_routes.signup_screen);
        },
        child: Text(
          "SIGN UP",
          style: TextStyle(
              fontSize: 3.5 * width_block,
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontVariations: <FontVariation>[FontVariation('wght', 700)]),
        ),
      )
    ],
  );
}

Widget existing_user_button(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Already Registered?",
        style: TextStyle(
            color: Colors.white70,
            fontFamily: 'Montserrat',
            fontVariations: <FontVariation>[FontVariation('wght', 500)],
            fontSize: 3 * width_block),
      ),
      TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, app_routes.signin_screen);
        },
        child: Text(
          "LOGIN HERE",
          style: TextStyle(
              fontSize: 3.5 * width_block,
              color: Colors.white,
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
        if (function == null) {
          function() {}
        } else {
          function(input_number);
        }
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
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget otp_field(BuildContext context, {function}) {
  final size = MediaQuery.of(context).size;
  return OTPTextField(
    keyboardType: TextInputType.number,
    length: 6,
    width: size.width > 330 ? 330 : size.width - 10,
    fieldWidth: size.width > 330 ? 330 / 7 : (size.width - 10) / 7,
    style: const TextStyle(fontSize: 20),
    textFieldAlignment: MainAxisAlignment.spaceAround,
    otpFieldStyle: OtpFieldStyle(
        borderColor: Colors.white, enabledBorderColor: Colors.white),
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
  final width_block = size.width / 100;
  final height_block = size.height / 100;
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
                : TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resent the OTP",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
            Text(
              error_line,
              style: TextStyle(fontSize: 4 * width_block, color: Colors.red),
            )
          ],
        ),
      ),
      SizedBox(height: height_block),
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
          color: Colors.white70),
    ),
  );
}

Widget error_line(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  return SizedBox(
    height: 6 * width_block,
    child: Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 2 * width_block),
        child: Text(
          text,
          style: TextStyle(fontSize: 4 * width_block, color: font_red_color),
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
    const SizedBox(height: 30),
    phone_number_field(context, function: phone_number_controller_function),
    const SizedBox(height: 10),
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
      const SizedBox(height: 10),
      otp_field(context, function: otp_controller_function),
      SizedBox(
        width: size.width > 330 ? 330 : size.width - 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Resend",
                style: TextStyle(fontSize: 3 * width_block),
              ),
            ),
            (full_otp == null || full_otp)
                ? const SizedBox(width: 50)
                : const Text(
                    "Enter The Entire OTP",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  )
          ],
        ),
      ),
      button_style("Submit", context, function: submit_button_function),
      const SizedBox(height: 10),
    ],
  );
}

bool isEmail(String email) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return true;
  } else {
    return false;
  }
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

class PasswordChecker {
  late String? Password;
  late String? Re_Password;
  String error_line = " ";
  bool valid = true;

  PasswordChecker(String? Password, String? Re_Password) {
    this.Password = Password;
    this.Re_Password = Re_Password;

    if (Password == null) {
      error_line = " ";
      valid = false;
    } else if (!isStrong(Password)) {
      error_line = "Weak Password";
      valid = false;
    } else if (Password != Re_Password) {
      error_line = "Password Do No Match";
      valid = false;
    } else {
      error_line = " ";
      valid = true;
    }
  }
  String get error {
    return error_line;
  }

  bool get ifError {
    return valid;
  }
}

Future<String?> idgrabber() async {
  try {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  } catch (er) {}
}

Future<String?> tokengrabber() async {
  try {
    final storage = new FlutterSecureStorage();
    final atoken = await storage.read(key: 'access_token');
    return atoken;
  } catch (er) {}
}

Future<dynamic?> userinfograbber() async {
  try {
    final user_info_storage = await SharedPreferences.getInstance();
    if (user_info_storage.getString("user_info") == null) {
      return "User Info Doesnt Exist";
    } else {
      final user_info = jsonDecode(user_info_storage.getString("user_info")!);

      return user_info;
    }
  } catch (er) {}
}

Widget AutoScroll(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  var texts = [
    "HUNGRY??",
    "COOKING GONE WRONG??",
    "UNEXPECTED GUESTS?",
    "LATE NIGHTS AT OFFICE?",
    "MOVIE MARATHON??",
    "GAME NIGHT??",
    "GATHERING AT HOME??",
    "FEELING LAZY?"
  ];
  return SizedBox(
    height: 6 * width_block,
    child: MarqueeVertical(
      itemCount: 8,
      itemBuilder: (index) {
        return Text(
          texts[index],
          textAlign: TextAlign.left,
          style: TextStyle(
              color: font_yellow_color,
              fontFamily: "Montserrat",
              fontSize: 6 * width_block,
              fontVariations: <FontVariation>[FontVariation('wght', 700)]),
        );
      },
      lineHeight: 8 * width_block,
      stopDuration: Duration(seconds: 5),
    ),
  );
}

Widget home_heading(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 4.5 * width_block,
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontVariations: <FontVariation>[FontVariation('wght', 500)],
      ),
      maxLines: 1,
    ),
  );
}

Widget home_search_bar(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      width: 90 * width_block,
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          suffixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    ),
  );
}

Widget home_section_heading(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 5 * width_block,
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontVariations: <FontVariation>[FontVariation('wght', 700)],
      ),
      maxLines: 1,
    ),
  );
}

Widget category_list(context, category_tap_function(int index),
    {int active_category = 0}) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  var icons = [
    Icons.room_service_sharp,
    Icons.fastfood_sharp,
    Icons.cake_sharp,
    Icons.local_pizza_sharp,
    Icons.lunch_dining_sharp,
    Icons.ramen_dining_sharp,
    Icons.set_meal_sharp,
    Icons.soup_kitchen_sharp
  ];
  var description = [
    "All",
    "FastFood",
    "Cake",
    "Pizza",
    "Burger",
    "Noodles",
    "Fish",
    "Soup"
  ];
  return SizedBox(
    height: size.height > 460 ? 12 * height_block : 460 * 0.12,
    child: ListView.builder(
      itemCount: 8,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              category_tap_function(index);
            },
            child: Container(
              decoration: index == active_category
                  ? BoxDecoration(
                      border:
                          Border.all(width: 1, color: home_background_color),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x55FFFFFF),
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10))
                  : BoxDecoration(),
              width: 20 * width_block,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icons[index],
                    color: Colors.white,
                  ),
                  Text(
                    description[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget food_suggested_list(context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  var images_path = [
    "assets/images/food_items/item1.png",
    "assets/images/food_items/item2.png",
    "assets/images/food_items/item3.png",
    "assets/images/food_items/item4.png",
    "assets/images/food_items/item5.png",
    "assets/images/food_items/item6.png",
    "assets/images/food_items/item7.png",
    "assets/images/food_items/item8.png",
    "assets/images/food_items/item9.png",
  ];

  var description = [
    "All",
    "FastFood",
    "Cake",
    "Pizza",
    "Burger",
    "Noodles",
    "Fish",
    "Soup",
    "Rice"
  ];
  var ratings = [
    3.6,
    4.5,
    1.6,
    4,
    2.3,
    1.6,
    2.6,
    4,
    6,
  ];
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, app_routes.food_description);
    },
    child: SizedBox(
      height: size.height > 510 ? 30 * height_block : 510 * 0.3,
      child: ListView.builder(
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: card_background_color,
            ),
            width: 40 * width_block,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images_path[index],
                      height:
                          size.height > 500 ? 15 * height_block : 500 * 0.15,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description[index],
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 500)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
                        decoration: BoxDecoration(
                            color: rating_background_color,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(children: [
                          Text(
                            ratings[index].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 500)
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.star_border_sharp,
                            color: Colors.white,
                          )
                        ]),
                      ),
                      IconButton(
                          padding: EdgeInsets.all(2),
                          constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle_outline_sharp,
                            color: rating_background_color,
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget restraunt_suggested_list(context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  var images_path = [
    "assets/images/food_items/item1.png",
    "assets/images/food_items/item2.png",
    "assets/images/food_items/item3.png",
    "assets/images/food_items/item4.png",
    "assets/images/food_items/item5.png",
    "assets/images/food_items/item6.png",
    "assets/images/food_items/item7.png",
    "assets/images/food_items/item8.png",
    "assets/images/food_items/item9.png",
  ];

  var description = [
    "Cafe A",
    "Cafe B",
    "Cafe C",
    "CAfe D",
    "Cafe E",
    "Cafe F",
    "Cafe G",
    "Cafe H",
    "Cafe I"
  ];
  var ratings = [
    3.0,
    4.2,
    5,
    1,
    4,
    1.1,
    2.2,
    4.5,
    2.9,
  ];
  return SizedBox(
    height: size.height > 510 ? 24 * height_block : 510 * 0.24,
    child: ListView.builder(
      itemCount: 9,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 50 * width_block,
          child: Card(
            color: card_background_color,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      images_path[index],
                      width: 45 * height_block,
                      height: 10 * height_block,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description[index],
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 500)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 12 * width_block,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.stars_sharp,
                                color: font_green_color,
                              ),
                              Text(
                                ratings[index].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontVariations: <FontVariation>[
                                    FontVariation('wght', 500)
                                  ],
                                ),
                              )
                            ]),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(2),
                              constraints: BoxConstraints(),
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_circle_outline_sharp,
                                color: rating_background_color,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget Navbar_Item(
    BuildContext context, IconData icon, String text, on_click()) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return TextButton(
    onPressed: on_click,
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 5 * width_block,
            fontFamily: "Montserrat",
            fontVariations: <FontVariation>[FontVariation('wght', 500)],
          ),
        )
      ],
    ),
  );
}

Widget loading_screen(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Container(
    height: size.height,
    child: CircularProgressIndicator(color: font_yellow_color),
  );
}

Widget price_display(BuildContext context, int price) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      "RS. " + price.toString(),
      style: TextStyle(
          color: font_green_color,
          fontSize: 4 * width_block,
          fontFamily: "Montserrat",
          fontVariations: <FontVariation>[FontVariation('wght', 700)]),
    ),
  );
}

Widget food_description_display(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return Text(
    text,
    textAlign: TextAlign.justify,
    style: TextStyle(
        color: Colors.white,
        fontSize: 4 * width_block,
        fontFamily: "Montserrat",
        fontVariations: <FontVariation>[FontVariation('wght', 400)]),
  );
}
