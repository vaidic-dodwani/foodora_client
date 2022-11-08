import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/designing.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  // TextEditingController _phonecontroller = new TextEditingController();
  TextEditingController _passcontroller = new TextEditingController();
  bool _showpass = false;
  // String _phone_error_line = "";
  String _password_error_line = "";
  String _button_msg = "Submit";
  bool _isloading = false;
  dynamic _user_info;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userinfograbber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _user_info = snapshot.data;
          return profile(context);
        } else {
          return loading_screen(context);
        }
      },
    );
  }

  Widget profile(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: background_color,
          child: Column(
            children: [
              Container(
                height: 95 * height_block,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: width_block * 20,
                          backgroundImage: const AssetImage(
                            "assets/images/photo.jpeg",
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            log("change image");
                          },
                          child: Text(
                            "Change Image",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 4 * width_block,
                              fontVariations: const <FontVariation>[
                                FontVariation('wght', 700)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     form_text(
                    //       context,
                    //       "Update Phone Number",
                    //     ),
                    //     SizedBox(height: 2 * height_block),
                    //     phone_form_field(
                    //       context,
                    //       "Enter New Phone Number",
                    //       maxlen: 10,
                    //       controller: _phonecontroller,
                    //     ),
                    //     SizedBox(height: 2 * height_block),
                    //     error_line(context, _phone_error_line)
                    //   ],
                    // ),
                    Column(
                      children: [
                        form_text(
                          context,
                          "Update Password",
                        ),
                        SizedBox(height: 2 * height_block),
                        form_field(context, "Enter New Pasword",
                            controller: _passcontroller,
                            password: _showpass,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showpass = !_showpass;
                                });
                              },
                              icon: _showpass
                                  ? const Icon(
                                      Icons.visibility_off_sharp,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.visibility_sharp,
                                      color: Colors.white,
                                    ),
                            )),
                        SizedBox(height: 2 * height_block),
                        error_line(context, _password_error_line)
                      ],
                    ),
                    SizedBox(
                      height: 5 * height_block,
                      child: _isloading
                          ? Center(
                              child: SizedBox(
                                  height: 4 * height_block,
                                  width: 4 * height_block,
                                  child: CircularProgressIndicator(
                                    color: font_yellow_color,
                                  )))
                          : SizedBox(
                              height: 5 * height_block,
                            ),
                    )
                  ],
                ),
              ),
              Container(
                width: 100 * width_block,
                height: 5 * height_block,
                child: ElevatedButton(
                  onPressed: () async {
                    // if (_phonecontroller.text.toString().length < 10) {
                    //   _phone_error_line = "Enter Entire Phone Number";
                    // } else
                    if (!isStrong(_passcontroller.text)) {
                      // _phone_error_line = "";
                      _password_error_line = "WEAK PASS";
                    } else {
                      // _phone_error_line = "";

                      final response = await forget_new_password(
                          _user_info['emailid'], _passcontroller.text);
                      if (response['success']) {
                        Navigator.pop;
                      } else {
                        setState(() {
                          _password_error_line = response['msg'];
                        });
                      }
                      _password_error_line = "";
                    }
                    setState(() {});
                  },
                  child: Text(_button_msg),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(font_red_color)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
