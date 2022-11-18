import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
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
    List<Widget> imgshow = [];
    for (int i = 0; i < widget.restraunt_detail['imgpath'].length; ++i) {
      imgshow.insert(
          i,
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                backend_link + widget.restraunt_detail['imgpath'][i],
                height: 40 * height_block,
                width: 95 * width_block,
                fit: BoxFit.fill,
              ),
            ),
          ));
    }

    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 4 * height_block),
            Container(
              width: 100 * width_block,
              height: 40 * height_block,
              child: CarouselSlider(
                  options: CarouselOptions(
                      height: 35 * height_block, autoPlay: true),
                  items: imgshow),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.restraunt_detail['restaurantname'].toUpperCase(),
                  style: TextStyle(
                      color: font_yellow_color,
                      fontFamily: "Montserrat",
                      fontVariations: <FontVariation>[
                        FontVariation('wght', 700)
                      ],
                      fontSize: 6 * width_block),
                ),
              ),
            ),
            SizedBox(height: height_block),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  (widget.restraunt_detail['restaurant_openingtime'] +
                          ' - ' +
                          widget.restraunt_detail['restaurant_closingtime'])
                      .toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontVariations: <FontVariation>[
                        FontVariation('wght', 500)
                      ],
                      fontSize: 4 * width_block),
                ),
              ),
            ),
            Divider(
              height: 1 * height_block,
              color: Colors.white,
            ),
            Text(
              "MENU",
              style: TextStyle(
                fontSize: 10 * width_block,
                color: font_red_color,
                fontFamily: "Montserrat",
                fontVariations: <FontVariation>[FontVariation('wght', 700)],
              ),
            ),
            widget.restraunt_detail['food_list'].length > 0
                ? SingleChildScrollView(
                    child: Container(
                      height: 60 * height_block,
                      child: ListView.builder(
                        itemCount: widget.restraunt_detail['food_list'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 8 * height_block,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, app_routes.food_description,
                                      arguments: [
                                        widget.restraunt_detail['_id'],
                                        widget.restraunt_detail['food_list']
                                            [index]
                                      ]);
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 2 * width_block),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              widget
                                                  .restraunt_detail["food_list"]
                                                      [index]['foodname']
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 5 * width_block,
                                                  color: font_yellow_color,
                                                  fontFamily: "Montserrat",
                                                  fontVariations: const <
                                                      FontVariation>[
                                                    FontVariation('wght', 500)
                                                  ]),
                                            ),
                                            Text(
                                              "₹ ${widget.restraunt_detail["food_list"][index]['food_price']}",
                                              style: TextStyle(
                                                fontSize: 5 * width_block,
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                                fontVariations: const <
                                                    FontVariation>[
                                                  FontVariation('wght', 500)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1.5, horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      rating_background_color,
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Row(children: [
                                                Text(
                                                  widget.restraunt_detail[
                                                          "food_list"][index]
                                                          ['food_rating']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Montserrat",
                                                    fontVariations: <
                                                        FontVariation>[
                                                      FontVariation('wght', 500)
                                                    ],
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star_border_sharp,
                                                  color: Colors.white,
                                                )
                                              ])),
                                        ],
                                      ),
                                    ]),
                              ));
                        },
                      ),
                    ),
                  )
                : Text(
                    "No Dishes Here SAD :(",
                    style: TextStyle(
                        fontSize: 6 * width_block,
                        color: font_yellow_color,
                        fontFamily: "Montserrat",
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 500)
                        ]),
                  )
          ],
        ),
      ),
    );
  }
}
