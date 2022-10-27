import 'package:geocoding/geocoding.dart';
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
  late List<Placemark> _placemarks;
  late Placemark _placemark;
  @override
  Widget build(BuildContext context) {
    final location = location_package.location_package.Location();

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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
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
              ),
              //
              SizedBox(height: size.height * 0.1),
              //
              SvgPicture.asset('assets/images/map.svg'),
              //
              SizedBox(height: size.height * 0.05),
              //

              button_style(
                'ENTER MANUALLY',
                context,
                color: Color(0x00000000),
                fontcolor: font_brown_color,
              ),
              SizedBox(
                height: size.height * 0.025,
              ),

              _location_recieved
                  ? lat_long_display(_placemark)
                  : (IsLoading == null || IsLoading == false)
                      ? button_style(
                          'CURRENT LOCATION',
                          context,
                          fontcolor: Colors.white,
                          color: orange_button_color,
                          function: () async {
                            if (await Permission.location.request().isGranted) {
                              setState(() {
                                IsLoading = true;
                              });
                              _current_location = await location.getLocation();
                              _placemarks = await placemarkFromCoordinates(
                                  _current_location.latitude!,
                                  _current_location.longitude!);
                              IsLoading = false;
                              _location_recieved = true;
                              _placemark = _placemarks[1];
                              setState(() {});
                            }
                          },
                        )
                      : const SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            color: font_brown_color,
                          ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget lat_long_display(Placemark placemark) {
  return Text(
    "You Are At:  " +
        placemark.subLocality.toString() +
        " , " +
        placemark.locality.toString(),
    style: TextStyle(
        fontSize: 16,
        color: font_brown_color,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700),
  );
}
