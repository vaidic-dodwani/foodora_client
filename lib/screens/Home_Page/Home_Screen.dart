import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';

class homepage_screen extends StatefulWidget {
  const homepage_screen({super.key});

  @override
  State<homepage_screen> createState() => _homepage_screenState();
}

int _active_category = 0;

class _homepage_screenState extends State<homepage_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return SingleChildScrollView(
      child: Container(
        width: 100 * width_block,
        child: Padding(
          padding: EdgeInsets.only(
              left: 4 * width_block,
              right: 2 * width_block,
              top: 1 * height_block),
          child: Column(
            children: [
              AutoScroll(context),
              SizedBox(height: 2 * height_block),
              home_heading(context, "Order From Your Favourite Restaurant"),
              SizedBox(height: height_block),
              SizedBox(height: 3 * height_block),
              restraunt_suggested_list(context)
            ],
          ),
        ),
      ),
    );
  }
}
