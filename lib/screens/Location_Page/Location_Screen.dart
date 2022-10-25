import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/designing.dart';
import 'package:permission_handler/permission_handler.dart';

class location_screen extends StatelessWidget {
  const location_screen({super.key});

  @override
  Widget build(BuildContext context) {
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
              button_style('Current Location', context,
                  color: orange_button_color)
            ],
          ),
        ),
      ),
    );
  }
}
