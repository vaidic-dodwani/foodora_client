import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';
import 'package:foodora/screens/Home_Page/Home_Screen.dart';
import 'package:foodora/screens/Home_Page/cart_screen.dart';
import 'package:foodora/screens/Home_Page/favorite_screen.dart';
import 'package:foodora/screens/Home_Page/notification_screen.dart';

class homepage_redirector extends StatefulWidget {
  const homepage_redirector({super.key});

  @override
  State<homepage_redirector> createState() => _homepage_redirectorState();
}

int _screen = 0;
void screen_selector(int screen) {
  _screen = screen;
}

class _homepage_redirectorState extends State<homepage_redirector> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;
    return Scaffold(
      backgroundColor: home_background_color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2 * width_block),
              child: Icon(Icons.location_on_outlined),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("INDRAPURAM"),
                Text("ABC STREET"),
              ],
            ),
          ],
        ),
        actions: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: EdgeInsets.all(constraints.maxHeight * 0.1),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/photo.jpeg",
                  height: constraints.maxHeight * 0.4,
                ),
              ),
            );
          })
        ],
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
            BottomNavigationBarItem(icon: Icon(Icons.home_sharp), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_sharp), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_sharp), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          ],
          onTap: (int s) {
            setState(() {
              screen_selector(s);
            });
          }),
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
