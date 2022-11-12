import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/screens/Auth_Page/auth_choice.dart';
import 'package:foodora/screens/Home_Page/Home_Redirector.dart';
import 'package:foodora/screens/Location_Page/Location_Screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class redirector extends StatefulWidget {
  const redirector({super.key});

  @override
  State<redirector> createState() => _redirectorState();
}

class _redirectorState extends State<redirector> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tokengrabber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null || snapshot.data == 'GUEST USER') {
          return auth_choice();
        } else if (snapshot.hasData) {
          if (JwtDecoder.isExpired(snapshot.data)) {
            storage.delete(key: 'access_token');
            return redirector();
          } else {
            return location_screen();
          }
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        ;
      },
    );
  }
}
