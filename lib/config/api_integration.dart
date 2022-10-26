import 'dart:convert';
import 'package:foodora/config/api_links.dart';
import 'package:http/http.dart';

dynamic sign_in() async {
  try {
    final response = await post(Uri.parse(sign_in_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": "vaidicdodwani@gmail.com",
          "password": "abcdxyz"
        }));
    final output = jsonDecode(response.body);

    return output;
  } catch (er) {}
}
