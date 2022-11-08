import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';

class food_description extends StatefulWidget {
  const food_description({super.key});

  @override
  State<food_description> createState() => _food_descriptionState();
}

class _food_descriptionState extends State<food_description> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/food_items/item1.png",
            width: 100 * width_block,
            height: 60 * height_block,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: background_color),
              height: 50 * height_block,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      width: 100 * width_block,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 50 * width_block,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5 * width_block),
                              child: Text(
                                "AFGHANI SPAGHETTI",
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontVariations: const <FontVariation>[
                                      FontVariation('wght', 500)
                                    ],
                                    color: font_yellow_color,
                                    fontSize: 7.5 * width_block),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_sharp,
                              color: font_red_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    price_display(context, 299),
                    Container(
                      height: 28 * height_block,
                      child: SingleChildScrollView(
                          child: food_description_display(context,
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: font_red_color),
                            onPressed: () {
                              log("Add To Cart");
                            },
                            child: Container(
                              width: 100 * width_block,
                              child: Text(
                                "Add To Cart",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 6 * width_block,
                                  fontVariations: <FontVariation>[
                                    const FontVariation('wght', 400)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
