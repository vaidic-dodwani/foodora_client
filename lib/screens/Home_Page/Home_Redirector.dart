import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodora/app_routes.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/screens/Home_Page/Home_Screen.dart';
import 'package:foodora/screens/Home_Page/cart_screen.dart';
import 'package:foodora/screens/Home_Page/favorite_screen.dart';
import 'package:foodora/screens/Home_Page/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage_redirector extends StatefulWidget {
  const homepage_redirector({super.key});

  @override
  State<homepage_redirector> createState() => _homepage_redirectorState();
}

int _screen = 0;
void screen_selector(int screen) {
  _screen = screen;
}

final storage = new FlutterSecureStorage();

class _homepage_redirectorState extends State<homepage_redirector> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userinfograbber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final user_info = snapshot.data;
        final size = MediaQuery.of(context).size;
        final width_block = size.width / 100;
        final height_block = size.height / 100;
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: home_background_color,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2 * width_block),
                    child: Icon(Icons.location_on_outlined),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40 * width_block,
                        child: Text(
                          user_info['address'].toString(),
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 3 * width_block,
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 700)
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 24,
                          backgroundImage: AssetImage(
                            "assets/images/photo.jpeg",
                          )),
                    ),
                  );
                })
              ],
            ),
            drawer: Container(
              width: size.width,
              child: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: Drawer(
                  child: Stack(children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.05)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5 * width_block),
                      child: Container(
                        width: 65 * width_block,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5 * height_block),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                            SizedBox(height: height_block),
                            const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 32,
                                backgroundImage: AssetImage(
                                  "assets/images/photo.jpeg",
                                )),
                            SizedBox(height: height_block),
                            Text(
                              user_info['username'],
                              style: TextStyle(
                                  fontSize: 8 * width_block,
                                  fontFamily: "Montserrat",
                                  color: Colors.white70,
                                  fontVariations: const <FontVariation>[
                                    FontVariation('wght', 400)
                                  ]),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Navbar_Item(
                                      context,
                                      Icons.person_outline_sharp,
                                      "Edit Profile", () async {
                                    log("Profileeee");
                                    if (user_info['username'] == "Guest User") {
                                    } else {
                                      Navigator.pushReplacementNamed(
                                          context, app_routes.profile_page);
                                    }
                                  }),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Navbar_Item(
                                      context,
                                      Icons.shopping_cart_outlined,
                                      "Order History", () {
                                    log("Order");
                                  }),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Navbar_Item(
                                      context,
                                      Icons.privacy_tip_outlined,
                                      "Privacy Policy", () {
                                    log("Privacy Policy");
                                  }),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.white,
                                  ),
                                  Navbar_Item(
                                      context,
                                      Icons.sticky_note_2_outlined,
                                      "About", () {
                                    log("About");
                                  }),
                                  SizedBox(
                                    height: 10 * height_block,
                                  ),
                                  Navbar_Item(context, Icons.arrow_back_sharp,
                                      "Signout", () async {
                                    await storage.deleteAll();
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    await preferences.clear();
                                    Navigator.pushReplacementNamed(
                                        context, app_routes.auth_choice);
                                  }),
                                  SizedBox(
                                    height: 10 * height_block,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            body: screen_returner(_screen),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: nav_bar_color,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                iconSize: 24,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                currentIndex: _screen,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_sharp), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_sharp), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_sharp), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications), label: ""),
                ],
                onTap: (int s) {
                  setState(() {
                    screen_selector(s);
                  });
                }),
          );
        } else {
          return loading_screen(context);
        }
      },
    );
  }
}

Widget screen_returner(int screen) {
  if (screen == 0) return homepage_screen();
  if (screen == 1) return favourite_screen();
  if (screen == 2)
    return cart_screen();
  else
    return notification_screen();
}
