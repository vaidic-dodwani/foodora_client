import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
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
        future: userinfograbber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final orders = snapshot.data['orderhistory'];
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
                                      height: 30 * height_block,
                                      child: ListView.builder(
                                        itemCount: orders[index].length,
                                        itemBuilder: (context, food_number) {
                                          return Container(
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
                                                      orders[index][food_number]
                                                                  ['quantity']
                                                              .toString() +
                                                          ' X ' +
                                                          orders[index][
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
                                                      child: Text(
                                                          "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
                                                    ),
                                                    width: 40 * width_block,
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
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
