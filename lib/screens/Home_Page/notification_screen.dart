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
            if (orders != []) {
              return Column(
                children: [
                  Container(
                    // color: Colors.white38,
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.85,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 110, 110, 110),
                            width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              textgenerator(
                                  'Your Past Orders',
                                  MediaQuery.of(context).size.width / 15,
                                  'RaleWay',
                                  200,
                                  Colors.white),
                              Divider(
                                color: Colors.white38,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                              itemCount: orders.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) => Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 110, 110, 110)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                    height: 130,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color.fromARGB(
                                                              255,
                                                              110,
                                                              110,
                                                              110)),
                                                      // borderRadius: BorderRadius.all(Radius.circular(20))
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            textgenerator(
                                                                'Food',
                                                                20,
                                                                'Raleway',
                                                                500,
                                                                Colors.white),
                                                            Divider(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                            textgenerator(
                                                                'Quantity',
                                                                20,
                                                                'Raleway',
                                                                500,
                                                                Colors.white),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 80,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                orders[index]
                                                                    .length,
                                                            itemBuilder: ((context,
                                                                    food_index) =>
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            110,
                                                                            110,
                                                                            110)),
                                                                    // borderRadius: BorderRadius.all(Radius.circular(20))
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          textgenerator(
                                                                              orders[index][food_index]['foodname'],
                                                                              18,
                                                                              'Raleway',
                                                                              500,
                                                                              Colors.white),
                                                                          textgenerator(
                                                                              orders[index][food_index]['quantity'].toString(),
                                                                              18,
                                                                              'Raleway',
                                                                              500,
                                                                              Colors.white),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text("Nothing in your history"));
            }
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
