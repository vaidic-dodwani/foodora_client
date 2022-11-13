import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodora/config/api_integration.dart';
import 'package:foodora/config/api_links.dart';
import 'package:foodora/designing.dart';
import 'package:image_picker/image_picker.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  String _password_error_line = "";
  String _button_msg = "Submit";
  bool _isloading = false;
  dynamic _user_info;
  final ImagePicker _picker = ImagePicker();
  XFile? _profile_image;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userinfograbber(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _user_info = snapshot.data;
          return profile(context, _user_info);
        } else {
          return loading_screen(context);
        }
      },
    );
  }

  Widget profile(BuildContext context, _user_info) {
    final size = MediaQuery.of(context).size;
    final width_block = size.width / 100;
    final height_block = size.height / 100;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: background_color,
          child: Column(
            children: [
              Container(
                height: 95 * height_block,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        _profile_image != null
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: width_block * 20,
                                backgroundImage:
                                    FileImage(File(_profile_image!.path)))
                            : _user_info['imagepath'] == null
                                ? SvgPicture.asset(
                                    'assets/images/abstract-user-flat-1.svg',
                                    color: Colors.white,
                                    width: 40 * width_block,
                                  )
                                : Image.network(
                                    backend_link + _user_info['imagepath'],
                                    width: 40 * width_block,
                                  ),
                        TextButton(
                          onPressed: () async {
                            _profile_image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {});
                          },
                          child: Text(
                            "Upload Image",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 4 * width_block,
                              fontVariations: const <FontVariation>[
                                FontVariation('wght', 700)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5 * height_block,
                      child: _isloading
                          ? Center(
                              child: SizedBox(
                                  height: 4 * height_block,
                                  width: 4 * height_block,
                                  child: const CircularProgressIndicator(
                                    color: font_yellow_color,
                                  )))
                          : SizedBox(
                              height: 5 * height_block,
                            ),
                    )
                  ],
                ),
              ),
              Container(
                width: 100 * width_block,
                height: 5 * height_block,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_profile_image != null) {
                      File profile_file = File(_profile_image!.path);
                      final response = await profile_photo_update(profile_file);

                      await put_user_info();
                      Navigator.pop(context);
                    }
                    setState(() {});
                  },
                  child: Text(_button_msg),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(font_red_color)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
