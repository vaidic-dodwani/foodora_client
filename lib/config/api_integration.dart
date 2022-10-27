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
    if (response != null)
      log("Response Recieved as " + output['success'].toString());
    return output;
  } catch (er) {
    log("eror: " + er.toString());
  }
}

dynamic sign_up(String name, String email, String password) async {
  try {
    log("Started");
    final response = await post(Uri.parse(sign_up_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": name,
          "email": email,
          "password": password,
          "cpassword": password
        }));
    final output = jsonDecode(response.body);
    return output;
  } catch (er) {
    log("eror: " + er.toString());
  }

}
