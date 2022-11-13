import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/config/api_links.dart';
import 'package:foodora/designing.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search_controller = new TextEditingController();
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    String search_text = "";

    return SafeArea(
      child: Scaffold(
        backgroundColor: background_color,
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: home_search_bar(context, search_controller,
                        (String text) {
                      search_text = text;
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Search Results",
                      style: TextStyle(
                          fontSize: 5 * width_block,
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 600)
                          ],
                          fontFamily: "Montserrat",
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(child: search_results(context))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

FutureBuilder search_results(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;
  return FutureBuilder(
    future: search(""),
    builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final restaurant = snapshot.data;
        return SingleChildScrollView(
          child: Container(
            child: Wrap(
              children: List.generate(
                restaurant!.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, app_routes.restraunt_page,
                          arguments: restaurant[index]);
                    },
                    child: Container(
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
                              child: Image.network(
                                backend_link + restaurant[index]['imgpath'][0],
                                height: size.height > 500
                                    ? 15 * height_block
                                    : 500 * 0.15,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              restaurant[index]['restaurantname'],
                              style: TextStyle(
                                fontSize: 6 * width_block,
                                fontFamily: "Montserrat",
                                fontVariations: <FontVariation>[
                                  FontVariation('wght', 500)
                                ],
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
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: font_yellow_color,
          ),
        );
      }
    }),
  );
}
