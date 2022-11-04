import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class homepage_screen extends StatefulWidget {
  const homepage_screen({super.key});

  @override
  State<homepage_screen> createState() => _homepage_screenState();
}

class _homepage_screenState extends State<homepage_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/background.svg',
            alignment: Alignment.center,
            height: size.height,
            width: size.width,
          ),
          SingleChildScrollView(
            child: Container(
              width: 100 * width_block,
              height: 100 * height_block,
              child: Center(
                child: Text(
                  "HomePage",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
