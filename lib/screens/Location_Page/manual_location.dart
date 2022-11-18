import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/screens/Home_Page/restrauntpage.dart';
import 'package:http/http.dart';

class manual_location extends StatefulWidget {
  const manual_location({super.key});

  @override
  State<manual_location> createState() => _manual_locationState();
}

late Future<dynamic> user = userinfograbber();
TextEditingController _addresscontroller = new TextEditingController();
TextEditingController _pincontroller = new TextEditingController();
String pinerr = " ";
String adderr = " ";
bool isloading = false;

class _manual_locationState extends State<manual_location> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return FutureBuilder(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user_info = snapshot.data;
          return Scaffold(
            backgroundColor: background_color,
            body: SingleChildScrollView(
              child: Container(
                width: size.width,
                decoration: background_design(),
                child: Column(
                  children: [
                    SizedBox(height: 8 * height_block),
                    //
                    Align(
                        alignment: Alignment.centerLeft,
                        child: top_welcome_text(context,
                            'Hello!! ' + user_info['username'].toString())),
                    //
                    SizedBox(height: 1 * height_block),
                    //

                    //
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Where Do You Want To Order?',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Colors.white70,
                            fontVariations: <FontVariation>[
                              FontVariation("wght", 400)
                            ],
                          ),
                        ),
                      ),
                    ),
                    //

                    //
                    SvgPicture.asset('assets/images/map.svg'),
                    //
                    SizedBox(height: height_block * 2),
                    //
                    form_field(context, "Address",
                        controller: _addresscontroller),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: width_block * 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            adderr,
                            style: TextStyle(
                                fontVariations: <FontVariation>[
                                  FontVariation('wght', 500)
                                ],
                                color: font_red_color,
                                fontFamily: "Montserrat",
                                fontSize: 4 * width_block),
                          ),
                        ),
                      ),
                    ),
                    pincode(context, controller: _pincontroller),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: width_block * 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            pinerr,
                            style: TextStyle(
                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 500)
                                ],
                                color: font_red_color,
                                fontFamily: "Montserrat",
                                fontSize: 4 * width_block),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5 * height_block),
                    isloading
                        ? SizedBox(
                            height: 3 * height_block,
                            width: 3 * height_block,
                            child: CircularProgressIndicator(
                              color: font_red_color,
                            ),
                          )
                        : button_style("Proceed", context, function: () async {
                            if (!RegExp(r'^[0-9]+$')
                                .hasMatch(_pincontroller.text)) {
                              setState(() {
                                pinerr = "Invalid Pin Code";
                              });
                            } else {
                              setState(() {
                                pinerr = "";
                              });
                            }
                            if (_addresscontroller.text.length < 10) {
                              setState(() {
                                adderr = "Enter Full Address";
                              });
                            } else {
                              setState(() {
                                adderr = "";
                              });
                            }
                            if (adderr == "" && pinerr == "") {
                              setState(() {
                                isloading = true;
                              });
                              final response = await manual_location_api(
                                  _addresscontroller.text, _pincontroller.text);

                              await put_user_info();

                              setState(() {
                                isloading = false;
                              });
                              if (response['success']) {
                                Navigator.pushReplacementNamed(
                                    context, app_routes.homepage_redirector);
                              } else {
                                setState(() {
                                  pinerr = response['msg'];
                                });
                              }
                            }
                          })
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
