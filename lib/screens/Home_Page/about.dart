import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.8,
          margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('About Us',style: TextStyle(fontSize: 30,fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900,
                color: font_yellow_color),
              ),
              Text('Foodora was founded as food service in 2022 by Vaidic, Archas ,Uditya, Anshuman and Ishika who worked for SI. The website started as a restaurant listing and recommendation portal. They renamed the company Foodora in 2022 as they were unsure if they would "just stick to food" and also to avoid a potential naming conflict with Foodora.With the introduction of www.Zomato.com domains in 2011, Foodora also launched Foodora.xxx, a site dedicated to food porn.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: font_yellow_color,
              ),)
            ],
          ),
        ) 
        ),
    );
  }
}