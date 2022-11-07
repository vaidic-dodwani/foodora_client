import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../designing.dart';

class favourite_screen extends StatefulWidget {
  const favourite_screen({super.key});

  @override
  State<favourite_screen> createState() => _favourite_screenState();
}

class _favourite_screenState extends State<favourite_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    var images_path = [
      "assets/images/food_items/item1.png",
      "assets/images/food_items/item2.png",
      "assets/images/food_items/item3.png",
      "assets/images/food_items/item4.png",
      "assets/images/food_items/item5.png",
      "assets/images/food_items/item6.png",
      "assets/images/food_items/item7.png",
      "assets/images/food_items/item8.png",
      "assets/images/food_items/item9.png",
    ];

    var description = [
      "All",
      "FastFood",
      "Cake",
      "Pizza",
      "Burger",
      "Noodles",
      "Fish",
      "Soup",
      "Rice"
    ];
    var ratings = [
      3.6,
      4.5,
      1.6,
      4,
      2.3,
      1.6,
      2.6,
      4,
      6,
    ];
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            children: List.generate(8, (index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: 40 * width_block,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          images_path[index],
                          height: size.height > 500
                              ? 15 * height_block
                              : 500 * 0.15,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        description[index],
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 500)
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              padding: EdgeInsets.all(2),
                              constraints: BoxConstraints(),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_sharp,
                                color: font_red_color,
                              )),
                          IconButton(
                              padding: EdgeInsets.all(2),
                              constraints: BoxConstraints(),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_circle_outline_sharp,
                                color: font_red_color,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
