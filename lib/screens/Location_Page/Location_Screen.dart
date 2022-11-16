import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/designing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_package;
import 'package:shared_preferences/shared_preferences.dart';

class location_screen extends StatefulWidget {
  const location_screen({super.key});

  @override
  State<location_screen> createState() => _location_screenState();
}

class _location_screenState extends State<location_screen> {
  bool _location_recieved = false;
  bool? IsLoading;
  late location_package.LocationData _current_location;
  final storage = new FlutterSecureStorage();
  late Map user_info;
  late SharedPreferences user_info_shared;
  final location = location_package.Location();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return FutureBuilder(
      future: userinfograbber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          user_info = snapshot.data;
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
                        child: top_welcome_text(
                            context, 'Hello ${user_info['username']} !!')),
                    //
                    SizedBox(height: 1 * height_block),
                    //
                    Align(
                        alignment: Alignment.centerLeft,
                        child: top_welcome_text(
                            context, 'What\'s your location?')),
                    //
                    SizedBox(height: 1 * height_block),
                    //
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'To suggest better results, we need your location.....',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: Colors.white70,
                              fontVariations: <FontVariation>[
                                FontVariation("wght", 400)
                              ]),
                        ),
                      ),
                    ),
                    //
                    SizedBox(height: height_block * 5),
                    //
                    SvgPicture.asset('assets/images/map.svg'),
                    //
                    SizedBox(height: size.height * 0.05),
                    //

                    SizedBox(
                      height: size.height * 0.025,
                    ),

                    (IsLoading == null || IsLoading == false)
                        ? button_style(
                            'CURRENT LOCATION',
                            context,
                            function: () async {
                              if (await Permission.location
                                  .request()
                                  .isGranted) {
                                setState(() {
                                  IsLoading = true;
                                });
                                _current_location =
                                    await location.getLocation();

                                final address = await location_info(
                                    _current_location.latitude,
                                    _current_location.longitude);

                                await put_user_info();

                                Navigator.pushReplacementNamed(
                                    context, app_routes.homepage_redirector);

                                setState(() {
                                  _location_recieved = true;
                                });
                              } else {
                                await Permission.location.request();
                              }
                            },
                          )
                        : SizedBox(
                            width: 3 * height_block,
                            height: 3 * height_block,
                            child: const CircularProgressIndicator(
                              color: font_red_color,
                            )),
                    SizedBox(
                      height: 2 * height_block,
                    ),
                    button_style("ENTER MANUALLY", context, function: () {
                      Navigator.pushNamed(context, app_routes.manual_location);
                    })
                  ],
                ),
              ),
            ),
          ); 
        } else {
          return loading_screen(context);
        }
      },
    );
  }
}
