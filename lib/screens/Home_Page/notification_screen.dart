import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/config/api_links.dart';
import 'package:foodora/designing.dart';

class notification_screen extends StatefulWidget {
  const notification_screen({super.key});

  @override
  State<notification_screen> createState() => _notification_screenState();
}

class _notification_screenState extends State<notification_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return SingleChildScrollView(
      child: FutureBuilder(
        future: get_past_orders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final orders = snapshot.data!['orders'];
            if (orders.isNotEmpty) {
              return SingleChildScrollView(
                child: Container(
                  height: 80 * height_block,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 40 * height_block,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text(
                                  "Order Number #" + (index + 1).toString(),
                                  style: TextStyle(
                                      color: font_yellow_color,
                                      fontFamily: 'Montserrat',
                                      fontSize: 6 * width_block,
                                      fontVariations: <FontVariation>[
                                        FontVariation('wght', 600)
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18.0),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: 25 * height_block,
                                      child: ListView.builder(
                                        itemCount:
                                            orders[index]['order'].length,
                                        itemBuilder: (context, food_number) {
                                          double _rating = orders[index]
                                                      ['order'][food_number]
                                                  ['rating']
                                              .toDouble();
                                          return Container(
                                              height: 5 * height_block,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      orders[index]['order'][
                                                                      food_number]
                                                                  ['quantity']
                                                              .toString() +
                                                          ' X ' +
                                                          orders[index]['order']
                                                                      [
                                                                      food_number]
                                                                  ['foodname']
                                                              .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontVariations: <
                                                              FontVariation>[
                                                            FontVariation(
                                                                'wght', 500)
                                                          ]),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: RatingStars(
                                                        value: _rating,
                                                        valueLabelVisibility:
                                                            false,
                                                        onValueChanged:
                                                            (value) {
                                                          if (_rating == 0) {
                                                            log("Rateing me bro? that to with ${value}");
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                        orders[index]['status']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: font_yellow_color,
                                            fontFamily: 'Montserrat',
                                            fontSize: 6 * width_block,
                                            fontVariations: <FontVariation>[
                                              FontVariation('wght', 600)
                                            ])),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(height: 30 * height_block),
                  Center(
                      child: Text(
                    "Try Ordering Food From Us :D",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: font_yellow_color,
                        fontSize: 7 * width_block,
                        fontFamily: "Montserrat",
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 500)
                        ]),
                  )),
                ],
              );
            }
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
