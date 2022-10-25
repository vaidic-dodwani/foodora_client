import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

class location_screen extends StatefulWidget {
  const location_screen({super.key});

  @override
  State<location_screen> createState() => _location_screenState();
}

class _location_screenState extends State<location_screen> {
  bool _location_recieved = false;
  LocationData? current_location;
  @override
  Widget build(BuildContext context) {
    final location = Location();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: background_design(),
          child: Column(
            children: [
              SizedBox(height: 62),
              //
              top_welcome_text('Hello USER!!'),
              //
              SizedBox(height: 8),
              //
              top_welcome_text('What\'s your location?'),
              //
              SizedBox(height: 5),
              //
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'To suggest better results, we need your location.....',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: font_brown_color,
                  ),
                ),
              ),
              //
              SizedBox(height: size.height * 0.1),
              //
              SvgPicture.asset('assets/images/map.svg'),
              //
              SizedBox(height: size.height * 0.05),
              //

              button_style(
                'Enter Manually',
                context,
                color: Color(0x00000000),
                fontcolor: font_brown_color,
              ),
              SizedBox(
                height: size.height * 0.025,
              ),

              _location_recieved
                  ? lat_long_display(current_location)
                  : button_style(
                      'Current Location',
                      context,
                      color: orange_button_color,
                      function: () async {
                        if (await Permission.location.request().isGranted) {
                          current_location = await location.getLocation();
                          log(current_location.toString());
                          _location_recieved = true;
                          setState(() {});
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}

Widget lat_long_display(LocationData? current_location) {
  return (current_location == null
      ? Text("null")
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lattitude=" + current_location.latitude.toString(),
            ),
            SizedBox(width: 10),
            Text(
              "Longitude " + current_location.longitude.toString(),
            ),
          ],
        ));
}
