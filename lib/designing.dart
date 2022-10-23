import 'package:flutter/material.dart';

const background_top = Color(0xFFE3C766);
const background_bottom = Color(0xFFFFCC00);
const logo_brown_color = Color(0xFF61481C);
const font_brown_color = Color(0xFF61481C);
const button_background = Color(0xFF61481C);
BoxDecoration background_design() {
  return const BoxDecoration(
    gradient: LinearGradient(
        colors: [background_top, background_bottom],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  );
}

Widget skip_button() {
  return const Padding(
    padding: EdgeInsets.all(5),
    child: Text(
      "SKIP",
      style: TextStyle(
          fontSize: 24, color: font_brown_color, fontWeight: FontWeight.w700),
    ),
  );
}

Widget sign_button(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
  );
}

// BoxDecoration button_decoration() {
//   return BoxDecoration(
//       border: Border.all(color: button_background),
//       borderRadius: const BorderRadius.all(Radius.circular(20)));
// }

// ButtonStyle button_style() {
//   return ButtonStyle(

//     backgroundColor: MaterialStateProperty.all(button_background),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         side: const BorderSide(width: 1),
//       ),
//     ),
//   );
// }

SizedBox button_style(
    String text, BuildContext context, void Function() function) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
    height: 50,
    width: size.width > 330 ? 330 : size.width - 10,
    child: TextButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(button_background),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(width: 1),
          ),
        ),
      ),
      child: sign_button(text),
    ),
  );
}
