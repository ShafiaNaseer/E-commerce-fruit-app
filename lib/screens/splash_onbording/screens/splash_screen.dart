import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruit_hub/utils/imports/imports.dart';
import 'package:get/get_core/src/get_main.dart';

import 'onbording_screen.dart';

bool checking = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    getValidationData().then((value) => {
    Timer(Duration(seconds: 3),
    () => Get.off(value == false ? OnBoarding() : HomePage()))
    });
    super.initState();
  }

  Future<bool> getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    bool? logincheck = sharedPreferences.getBool('isLogin');
    return logincheck!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child:
                  Image(image: AssetImage('assets/images/splash_image.png'))),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Fruit Hub",
            style: TextStyle(fontSize: 15),
          )),
          SizedBox(
            height: 20,
          ),
          Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
        ],
      ),
    );
  }
}
