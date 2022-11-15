import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/config/api_links.dart';
import 'package:foodora/designing.dart';

class food_description extends StatefulWidget {
  final dynamic args;
  const food_description({super.key, required this.args});

  @override
  State<food_description> createState() => _food_descriptionState(this.args);
}

class _food_descriptionState extends State<food_description> {
  dynamic args;
  _food_descriptionState(this.args);
  dynamic _count;
  dynamic food_info;
  late String seller_id;
  int? count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = view_count(args[1]['foodname'], args[0]);
    food_info = args[1];
    seller_id = args[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;

    return FutureBuilder(
      future: _count,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (count == null) {
            count = snapshot.data as int;
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Image.network(
                  backend_link + food_info['imgpath'],
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
                                    padding:
                                        EdgeInsets.only(top: 5 * width_block),
                                    child: Text(
                                      food_info['foodname'],
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
                              ],
                            ),
                          ),
                          price_display(context, food_info['food_price']),
                          Container(
                            height: 28 * height_block,
                            child: SingleChildScrollView(
                                child: food_description_display(
                                    context, food_info['food_desc'])),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: cart_button(
                                    _count,
                                    context,
                                    food_info['foodname'],
                                    seller_id,
                                    food_info['_id'], () {
                                  add_to_cart(seller_id, food_info['_id']);
                                  setState(() {
                                    count = count! + 1;
                                  });
                                }, () {
                                  remove_from_cart(seller_id, food_info['_id']);
                                  setState(() {
                                    count = count! - 1;
                                  });
                                }, count),
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
        } else {
          return Container(
            color: background_color,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Widget cart_button(
    Future<int> _count,
    BuildContext context,
    String foodname,
    String seller_id,
    String food_id,
    add_to_function,
    decrease_count_function,
    count) {
  final size = MediaQuery.of(context).size;
  final width_block = size.width / 100;
  final height_block = size.height / 100;

  return (count == 0)
      ? ElevatedButton(
          style: ElevatedButton.styleFrom(primary: font_red_color),
          onPressed: add_to_function,
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
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: decrease_count_function,
                icon: Icon(
                  Icons.remove_circle_sharp,
                  color: font_yellow_color,
                )),
            Text(
              count.toString(),
              style: TextStyle(
                  color: font_yellow_color, fontSize: 4 * width_block),
            ),
            IconButton(
                onPressed: add_to_function,
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: font_yellow_color,
                ))
          ],
        );
}
