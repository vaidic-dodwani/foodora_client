import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_package;

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
  late String _userid;

  @override
  Widget build(BuildContext context) {
    final location = location_package.Location();
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return FutureBuilder(
      future: idgrabber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _userid = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
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
                        child:
                            top_welcome_text(context, 'Hello ${_userid} !!')),
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
                              color: logo_brown_color,
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

                    button_style('ENTER MANUALLY', context,
                        color: Color(0x00000000), function: () {}),
                    SizedBox(
                      height: size.height * 0.025,
                    ),

                    _location_recieved
                        ? lat_long_display(_current_location)
                        : (IsLoading == null || IsLoading == false)
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

                                    IsLoading = false;
                                    _location_recieved = true;

                                    setState(() {});
                                  }
                                },
                              )
                            : SizedBox(
                                width: 3 * height_block,
                                height: 3 * height_block,
                                child: const CircularProgressIndicator(
                                  color: font_red_color,
                                ))
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

Widget lat_long_display(location_package.LocationData current_location) {
  return Text(
    "You Are At:  ${current_location.latitude} ${current_location.longitude}",
    style: const TextStyle(
        fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
  );
}

