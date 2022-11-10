import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/config/api_links.dart';
import 'package:foodora/designing.dart';

class restraunt_page extends StatefulWidget {
  final dynamic restraunt_detail;
  const restraunt_page({super.key, required this.restraunt_detail});

  @override
  State<restraunt_page> createState() => _restraunt_pageState();
}

class _restraunt_pageState extends State<restraunt_page> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 4 * height_block),
            Container(
              width: 100 * width_block,
              height: 40 * height_block,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.restraunt_detail['imgpath'].length,
                itemBuilder: (BuildContext context, int index) {
                  //design this
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          backend_link +
                              widget.restraunt_detail['imgpath'][index],
                          height: 35 * height_block,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: 1 * height_block,
              color: Colors.white,
            ),
            Text("MENU",
                style: TextStyle(
                    fontSize: 10 * width_block,
                    color: font_red_color,
                    fontFamily: "Montserrat",
                    fontVariations: <FontVariation>[
                      FontVariation('wght', 700)
                    ])),
            Container(
              height: 60 * height_block,
              child: ListView.builder(
                itemCount: widget.restraunt_detail['food_list'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 5 * height_block,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, app_routes.food_description,
                            arguments: widget.restraunt_detail['food_list']
                                [index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2 * width_block),
                            child: Text(
                              widget.restraunt_detail["food_list"][index]
                                  ['foodname'],
                              style: TextStyle(
                                  fontSize: 5 * width_block,
                                  color: font_yellow_color,
                                  fontFamily: "Montserrat",
                                  fontVariations: <FontVariation>[
                                    FontVariation('wght', 500)
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                                widget.restraunt_detail["food_list"][index]
                                        ['food_price']
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 5 * width_block,
                                    color: font_yellow_color,
                                    fontFamily: "Montserrat",
                                    fontVariations: <FontVariation>[
                                      FontVariation('wght', 500)
                                    ])),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
