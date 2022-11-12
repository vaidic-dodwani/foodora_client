import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:foodora/config/api_links.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

dynamic forget_otp_send(String email) async {
  try {
    log("Initialised Forget OTP sent for: " + email);
    final response = await post(Uri.parse(forget_otp_send_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": email}));
    final output = jsonDecode(response.body);
    log("otp send results: " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic forget_otp_verify(String email, String OTP) async {
  try {
    log("Initialised forget OTP verification begun for: " + email);
    final response = await post(Uri.parse(forget_otp_verify_link),
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

dynamic forget_new_password(String email, String password) async {
  try {
    log("Initialised Password Change Begun For: " + email);
    final response = await post(Uri.parse(forget_new_password_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}));
    final output = jsonDecode(response.body);
    log("set new password results: : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

//headd
Future<Map?> get_user_info(String? idtest) async {
  if (idtest == null) {
    return {"error": "ID IS NULL BROO"};
  }
  try {
    final storage = new FlutterSecureStorage();
    String? id = await storage.read(key: 'access_token');
    log("Initialised Profile get for: " + idtest);
    final response = await post(Uri.parse(user_profile_link),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: id!,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"_id": idtest}));
    final Map output = jsonDecode(response.body);
    log("response of the profile : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic location_info(double? lat, double? long) async {
  try {
    final storage = new FlutterSecureStorage();
    final id = await storage.read(key: 'token');
    if (id == null) {
      return {"error": "ID IS NULL BROO"};
    }
    log("Initialised Location get");
    final response = await post(Uri.parse(location_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: id,
        },
        body: jsonEncode(<String, dynamic>{
          "user_id": id,
          "latitude": lat!,
          "longitude": long!
        }));
    final output = jsonDecode(response.body);

    log("response of the location : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

Future<Map?> get_restaurant_feed() async {
  try {
    final storage = new FlutterSecureStorage();

    String? id = await storage.read(key: 'access_token');
    log("Initialised get feed for: " + id!);
    final response = await get(
      Uri.parse(feed_link),
      headers: {
        HttpHeaders.authorizationHeader: id,
      },
    );
    final Map output = jsonDecode(response.body);
    log("response of the feed : " + output.toString());

    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

Future<Map?> view_cart() async {
  final storage = new FlutterSecureStorage();
  final id = await storage.read(key: 'token');
  if (id == null) {
    return {"error": "ID IS NULL BROO"};
  }
  try {
    log("Initialised View Cart for: " + id);
    final response = await post(
      Uri.parse(view_cart_link),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: id,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user_id": id}),
      // body: jsonEncode(<String, String>{"user_id": "636b70ef1b089df87dfd079"}),
    );
    final Map output = jsonDecode(response.body);
    log("response of the cart : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

Future<List?>? search(String text) async {
  try {
    log("Initialised Search For: " + text);
    final response = await post(Uri.parse(search_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"text": text}));
    final output = jsonDecode(response.body);
    log("Search results: : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic view_count(String foodname, String seller_id) async {
  try {
    final storage = new FlutterSecureStorage();
    final id = await storage.read(key: 'token');

    log("sent count for: " + foodname);
    final response = await post(Uri.parse(view_count_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "foodname": foodname,
          "seller_id": seller_id,
          "user_id": id!
        }));
    final output = jsonDecode(response.body);
    log("count output : " + output.toString());
    return output['count'];
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic add_to_cart(String seller_id, String food_id) async {
  try {
    final storage = new FlutterSecureStorage();
    final id = await storage.read(key: 'token');

    log(seller_id);
    log(food_id);
    log(id!);
    final response = await post(Uri.parse(add_to_cart_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "seller_id": seller_id,
          "food_id": food_id,
          "user_id": id
        }));
    final output = jsonDecode(response.body);
    log("add to cart : " + output.toString());
    return output['count'];
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic remove_from_cart(String seller_id, String food_id) async {
  try {
    final storage = new FlutterSecureStorage();
    final id = await storage.read(key: 'token');

    log(seller_id);
    log(food_id);
    log(id!);
    final response = await post(Uri.parse(remove_from_cart_link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "seller_id": seller_id,
          "food_id": food_id,
          "user_id": id
        }));
    final output = jsonDecode(response.body);
    log("add to cart : " + output.toString());
    return output['count'];
  } catch (er) {
    log("error caught: " + er.toString());
  }
}

dynamic checkout() async {
  try {
    final storage = new FlutterSecureStorage();
    String? id = await storage.read(key: 'access_token');
    log("Initialised Profile get for: " + id!);
    final response = await post(Uri.parse(checkout_link),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: id!,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"_id": id}));
    final Map output = jsonDecode(response.body);
    log("checkout : " + output.toString());
    return output;
  } catch (er) {
    log("error caught: " + er.toString());
  }
}
