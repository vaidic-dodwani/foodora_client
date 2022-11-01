// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:foodora/config/api_links.dart';
import 'package:http/http.dart';

dynamic sign_in(String email, String password) async {
  try {
    log("Attempting Sign IN");
    final response = await post(Uri.parse(sign_in_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));

    final output = jsonDecode(response.body);
    if (response != null) {
      log("Response Recieved as " + output['success'].toString());
    }
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic sign_up(String name, String email, String password) async {
  try {
    log("Sign UP Started for " + email);
    final response = await post(Uri.parse(sign_up_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": name,
          "email": email,
          "password": password,
        }));
    final output = jsonDecode(response.body);
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic send_api_otp(String email) async {
  try {
    log("Initialised OTP send at: " + email);
    final response = await post(Uri.parse(otp_send_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
        }));
    final output = jsonDecode(response.body);
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic otp_correct(String email, String OTP) async {
  try {
    log("Initialised OTP verification begun for: " + email);
    final response = await post(Uri.parse(otp_check_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email, "otp": OTP}));
    final output = jsonDecode(response.body);
    log("otp check results: " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}
