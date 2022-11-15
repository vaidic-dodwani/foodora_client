import 'dart:developer';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/designing.dart';

class cart_screen extends StatefulWidget {
  const cart_screen({super.key});

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;

    return FutureBuilder(
      future: view_cart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!['cart'].isNotEmpty) {
            final cart = snapshot.data!['cart'];

            //
            //
            num item_calculator() {
              num sum_temp = 0;
              for (int i = 0; i < cart.length; ++i) {
                sum_temp += cart[i]['quantity'];
              }
              return sum_temp;
            }

            final total_items = item_calculator();
            num cost_calculator() {
              num sum_temp = 0;
              for (int i = 0; i < cart.length; ++i) {
                sum_temp += cart[i]['quantity'] * cart[i]['food_price'];
              }
              return sum_temp;
            }

            final total_cost = cost_calculator();

            return Stack(
              children: [
                Container(
                  height: 70 * height_block,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: List.generate(
                          cart.length,
                          (index) {
                            return Container(
                              height: 10 * height_block,
                              width: double.infinity,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          cart[index]['quantity'].toString() +
                                              'x',
                                          style: TextStyle(
                                            fontSize: 6 * width_block,
                                            fontFamily: "Montserrat",
                                            fontVariations: <FontVariation>[
                                              FontVariation('wght', 500)
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          cart[index]['foodname'],
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Text(
                                        cart[index]['food_price'].toString(),
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontVariations: <FontVariation>[
                                              FontVariation('wght', 500)
                                            ],
                                            fontSize: 6 * width_block),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40 * height_block,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: font_yellow_color),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 35 * height_block,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Items",
                                        style: bill_item_design(context),
                                      ),
                                      Text(
                                        total_items.toString(),
                                        style: bill_item_design(context),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Cost",
                                          style: bill_item_design(context)),
                                      Text(
                                        total_cost.toString(),
                                        style: bill_item_design(context),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tax(18%)",
                                        style: bill_item_design(context),
                                      ),
                                      Text(
                                        ((total_cost * 0.18).round())
                                            .toString(),
                                        style: bill_item_design(context),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Payable Amount",
                                        style: bill_item_design(context),
                                      ),
                                      Text(
                                        ((total_cost * 1.18).round())
                                            .toString(),
                                        style: bill_item_design(context),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 5 * height_block,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final response = await checkout();
                                  Fluttertoast.showToast(
                                      msg: response['msg'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        font_yellow_color)),
                                child: Center(
                                  child: Text(
                                    "Order Now",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 6 * width_block,
                                      color: background_color,
                                      fontVariations: <FontVariation>[
                                        FontVariation('wght', 700)
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
                child: Text(
              "Why Not Hungry? Add Items To Cart",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: font_yellow_color,
                  fontSize: 7 * width_block,
                  fontFamily: "Montserrat",
                  fontVariations: <FontVariation>[FontVariation('wght', 500)]),
            ));
          }
        } else {
          return Container(
            child: const Center(
                child: CircularProgressIndicator(
              color: font_yellow_color,
            )),
          );
        }
      },
    );
  }
}
