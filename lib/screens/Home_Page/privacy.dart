import 'package:flutter/material.dart';
import 'package:foodora/designing.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

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
            children: [
              Text('Privacy Policy',style: TextStyle(fontSize: 30,fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900,
                color: font_yellow_color),
              ),
              Text('This policy applies only to the information Foodora collects through its Services, in email, text and other electronic communications sent through or in connection with its Services.This policy DOES NOT apply to information that you provide to, or that is collected by, any third-party, such as restaurants at which you make reservations and/or pay through Foodora Services and social networks that you use in connection with its Services. Foodora encourages you to consult directly with such third-parties about their privacy practices. Please read this policy carefully to understand Foodora policies and practices regarding your information and how Foodora will treat it. By accessing or using its Services and/or registering for an account with Foodora, you agree to this privacy policy and you are consenting to Foodora collection, use, disclosure, retention, and protection of your personal information as described here. If you do not provide the information Zomato requires, Zomato may not be able to provide all of its Services to you',
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
